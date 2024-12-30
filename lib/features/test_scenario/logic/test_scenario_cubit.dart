import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_scenario_cubit.freezed.dart';
part 'test_scenario_executor.dart';

class TestScenarioCubit extends Cubit<TestScenarioState> {
  TestScenarioCubit({
    required this.sessionCubit,
    required this.settingsCubit,
    required this.testScenarioRepository,
    required this.networkEndpointRepository,
    required this.testScenario,
  }) : super(TestScenarioState.fromScenario(testScenario)) {
    _initialize();
  }

  final TestScenario testScenario;

  final ITestScenarioRepository testScenarioRepository;
  final INetworkEndpointRepository networkEndpointRepository;
  final SessionCubit sessionCubit;
  SessionState get _session => sessionCubit.state;
  final SettingsCubit settingsCubit;
  SettingsState get _settings => settingsCubit.state;

  String get _workingDirectory => join(
        _settings.workingDirectory,
        state.applicationId,
        state.name,
      );

  // TODO: Think about making it a variable configurable for each scenario/app
  int get _startAppDelay => 0;
  String get _videoStoragePathOnDevice => "/data/local/tmp/out.mp4";

  final SystemProcess _process = SystemProcess();

  Adb? _adbService;
  Adb get _adb {
    _adbService ??= Adb(
      settingsCubit,
      systemProcess: _process,
      device: state.device.isNotEmpty ? state.device : null,
    );
    return _adbService!;
  }

  Tshark? _tsharkService;
  Tshark get _tshark {
    _tsharkService ??= Tshark(settingsCubit, systemProcess: _process);
    return _tsharkService!;
  }

  void _emit(TestScenarioState state) => emit(state);

  StreamSubscription? sessionListener;

  @override
  Future<void> close() async {
    await super.close();
    await sessionListener?.cancel();
  }

  Future _initialize() async {
    sessionListener = sessionCubit.stream.listen((_) => checkDevice());
    checkDevice();
  }

  Future checkDevice() async {
    if (!_session.deviceConnected(testScenario.device)) return;

    if (testScenario.permissions.isEmpty) {
      await _loadAppPermissions();
    }
  }

  Future reset() async {
    testScenario.userInputRecord = "";
    testScenario.testConstellations = [];

    resetAllPermissionStates();
    await _clearFiles();
    _emit(TestScenarioState.fromScenario(testScenario));
  }

  Future delete() async {
    testScenarioRepository.delete(testScenario.id);

    await _clearFiles();
  }

  Future _clearFiles() async {
    Directory fileDir = Directory(_workingDirectory); //state.fileDirectory);
    if (await fileDir.exists()) {
      await fileDir.delete(recursive: true);
    }
  }

  Future _loadAppPermissions() async {
    var permissions = await _adb.getApplicationPermissions(state.applicationId);
    testScenario.permissions = permissions
        .map((p) =>
            PermissionSetting(permission: p, state: PermissionState.revoked))
        .toList();

    // in case an empty testConstellation was created, set the permissions
    for(var constellation in state.testConstellations){
      constellation.permissions = List.of(testScenario.permissions);
    }
    emit(state.copyWith(permissions: List.of(testScenario.permissions)));
  }

  void _storeScenario() {
    testScenarioRepository.update(testScenario);
  }

  void setName(String name) {
    testScenario.name = name;
    emit(state.copyWith(name: testScenario.name));
    _storeScenario();
  }

  void setDuration(int seconds) {
    // emit twice to ensure ui is updated
    testScenario.durationInSeconds = seconds;
    emit(state.copyWith(duration: testScenario.duration));
    if (state.recordScreen && seconds > 180) {
      seconds = 180;
      testScenario.durationInSeconds = seconds;
      emit(state.copyWith(duration: testScenario.duration));
    }
    _storeScenario();
  }

  void resetUserInput() {
    testScenario.userInputRecord = "";
    emit(state.copyWith(userInputRecord: testScenario.userInputRecord));
    _storeScenario();
  }

  void setNumTestRuns(int numTestRuns) {
    testScenario.numTestRuns = numTestRuns;
    emit(state.copyWith(numTestRuns: testScenario.numTestRuns));
    _storeScenario();
  }

  void _togglePermissionState(String permission) {
    testScenario.permissions = testScenario.permissions
        .map((p) => p.permission == permission
            ? PermissionSetting(permission: permission, state: p.state.next)
            : p)
        .toList();
  }

  void _updatePermissionState() {
    emit(state.copyWith(permissions: List.of(testScenario.permissions)));
    _storeScenario();
  }

  void togglePermissionState(String permission) {
    _togglePermissionState(permission);
    _updatePermissionState();
  }

  void toggleAllPermissionStates() {
    for (var permission in testScenario.permissions) {
      _togglePermissionState(permission.permission);
    }
    _updatePermissionState();
  }

  void resetAllPermissionStates() {
    testScenario.permissions = testScenario.permissions
        .map((p) => PermissionSetting(
            permission: p.permission, state: PermissionState.revoked))
        .toList();
    _updatePermissionState();
  }

  void toggleRecordScreen() {
    testScenario.recordScreen = !testScenario.recordScreen;
    emit(state.copyWith(recordScreen: testScenario.recordScreen));
    setDuration(testScenario.durationInSeconds);
    _storeScenario();
  }

  void toggleCaptureTraffic() {
    testScenario.captureTraffic = !testScenario.captureTraffic;
    emit(state.copyWith(captureTraffic: testScenario.captureTraffic));
    _storeScenario();
  }

  Future setEventInputDevice(AndroidInputDevice deviceInput) async {
    testScenario.deviceInput = deviceInput;
    emit(state.copyWith(deviceInput: deviceInput));
    _storeScenario();
  }

  Future setNetworkInterface(TsharkNetworkInterface interface) async {
    testScenario.networkInterface = interface;
    emit(state.copyWith(networkInterface: interface));
    _storeScenario();
  }

  List<PermissionSetting> _getPermissionConstellation(
      PermissionSetting dynamicSetting) {
    List<PermissionSetting> constellation = [];
    for (var p in testScenario.permissions) {
      // by default, set settings to revoked if not currently tested or actively granted
      PermissionState state = PermissionState.revoked;
      if (p.state == PermissionState.granted ||
          p.state == PermissionState.test &&
              p.permission == dynamicSetting.permission) {
        state = PermissionState.granted;
      }
      constellation
          .add(PermissionSetting(permission: p.permission, state: state));
    }
    return constellation;
  }

  /// add new constellations
  /// return the number of constellations that already existed
  Future<int> addConstellations() async {
    // set one constellations with all testing permissions revoked for reference
    List<TestConstellation> constellations = [
      TestConstellation(
          permissions: testScenario.permissions
              .map((p) => PermissionSetting(
                  permission: p.permission,
                  state: p.state == PermissionState.granted
                      ? PermissionState.granted
                      : PermissionState.revoked))
              .toList())
    ];
    for (var p in testScenario.permissions
        .where((p) => p.state == PermissionState.test)) {
      constellations.add(
        TestConstellation(permissions: _getPermissionConstellation(p)),
      );
    }
    // only add constellations that do not yet exist
    List<TestConstellation> newConstellations = constellations
        .where((tc) => !testScenario.testConstellations
            .any((tstc) => tc.abbreviation == tstc.abbreviation))
        .toList();
    testScenario.testConstellations = [
      ...testScenario.testConstellations,
      ...newConstellations,
    ];
    emit(state.copyWith(testConstellations: testScenario.testConstellations));
    _storeScenario();
    // returns the number of constellations that already existed
    return constellations.length - newConstellations.length;
  }

  void removeConstellation(TestConstellation tc) {
    List<TestConstellation> constellations =
        testScenario.testConstellations.toList();
    constellations.remove(tc);
    testScenario.testConstellations = constellations;
    emit(state.copyWith(testConstellations: testScenario.testConstellations));
    _storeScenario();
  }

  Future _setPermissions(List<PermissionSetting> permissions) async {
    for (var permission in permissions) {
      await _adb.setPermission(
        applicationId: testScenario.applicationId,
        permission: permission.permission,
        granted: permission.state == PermissionState.granted,
      );
    }
  }
}

@freezed
class TestScenarioState with _$TestScenarioState {
  const TestScenarioState._();

  const factory TestScenarioState({
    required bool loading,
    required String loadingInfo,
    required String applicationId,
    required String applicationName,
    required String name,
    required String fileDirectory,
    required String userInputRecord,
    required String device,
    required AndroidInputDevice deviceInput,
    required TsharkNetworkInterface networkInterface,
    required Duration duration,
    required int numTestRuns,
    required List<PermissionSetting> permissions,
    required bool recordScreen,
    required bool captureTraffic,
    required List<TestConstellation> testConstellations,
  }) = _TestScenarioState;

  factory TestScenarioState.empty() => const TestScenarioState(
        loading: false,
        loadingInfo: "",
        applicationId: "",
        applicationName: "",
        name: "",
        fileDirectory: "",
        userInputRecord: "",
        device: "",
        deviceInput: AndroidInputDevice(),
        networkInterface: TsharkNetworkInterface(),
        duration: Duration.zero,
        numTestRuns: 1,
        permissions: [],
        recordScreen: true,
        captureTraffic: true,
        testConstellations: [],
      );
  factory TestScenarioState.fromScenario(TestScenario scenario) =>
      TestScenarioState(
        loading: false,
        loadingInfo: "",
        userInputRecord: scenario.userInputRecord,
        applicationId: scenario.applicationId,
        applicationName: scenario.applicationName,
        device: scenario.device,
        deviceInput: scenario.deviceInput,
        networkInterface: scenario.networkInterface,
        name: scenario.name,
        fileDirectory: scenario.fileDirectory,
        duration: scenario.duration,
        numTestRuns: scenario.numTestRuns,
        permissions: List.of(scenario.permissions),
        recordScreen: scenario.recordScreen,
        captureTraffic: scenario.captureTraffic,
        testConstellations: List.of(scenario.testConstellations),
      );
  bool get hasInputRecord => userInputRecord.isNotEmpty;
  bool get hasTests => testConstellations.any((c) => c.testIds.isNotEmpty);
}
