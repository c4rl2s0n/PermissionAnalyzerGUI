import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_scenario_executor.dart';

class TestScenarioCubit extends Cubit<TestScenarioState> {
  TestScenarioCubit({
    required this.sessionCubit,
    required this.settingsCubit,
    required this.testScenarioRepository,
    required this.testScenario,
  }) : super(TestScenarioState.fromScenario(testScenario)) {
    _initialize();
  }

  final TestScenario testScenario;

  final ITestScenarioRepository testScenarioRepository;
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

  Future _initialize() async {
    //emit(state.copyWith(loading: true));
    if (_session.adbDevice.isEmpty) return;
    emit(state.copyWith(
        deviceFound: _session.adbDevices.contains(state.device)));
    if (testScenario.permissions.isEmpty) {
      await _loadAppPermissions();
    }
    //emit(state.copyWith(loading: false));
  }

  Future reset() async {
    testScenario.userInputRecord = "";
    testScenario.testConstellations = [];
    testScenario.analysis = null;

    resetAllPermissionStates();
    await _clearFiles();
    _emit(TestScenarioState.fromScenario(testScenario));
  }

  Future delete() async {
    testScenarioRepository.delete(testScenario.id);

    await _clearFiles();
  }
  Future _clearFiles()async{
    Directory fileDir = Directory(state.fileDirectory);
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
    testScenario.durationInSeconds = seconds;
    emit(state.copyWith(duration: testScenario.duration));
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
    // reset the testConstellations when permissions were changed
    testScenario.testConstellations = [];
    emit(state.copyWith(
      permissions: List.of(testScenario.permissions),
      testConstellations: List.of(testScenario.testConstellations),
    ));
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
    _storeScenario();
  }

  void toggleCaptureTraffic() {
    testScenario.captureTraffic = !testScenario.captureTraffic;
    emit(state.copyWith(captureTraffic: testScenario.captureTraffic));
    _storeScenario();
  }

  Future setAdbDevice(String device) async {
    testScenario.device = device;
    bool deviceFound = _session.adbDevices.contains(device);
    emit(state.copyWith(device: testScenario.device, deviceFound: deviceFound));
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

  Future createConstellations() async {
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
    for (var p in testScenario.permissions) {
      if (p.state == PermissionState.test) {
        constellations.add(
          TestConstellation(permissions: _getPermissionConstellation(p)),
        );
      }
    }
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

class TestScenarioState extends Equatable {
  const TestScenarioState({
    this.loading = false,
    this.deviceFound = false,
    this.loadingInfo = "",
    this.applicationId = "",
    this.applicationName = "",
    this.name = "",
    this.fileDirectory = "",
    this.userInputRecord = "",
    this.device = "",
    this.deviceInput = const AndroidInputDevice(),
    this.networkInterface = const TsharkNetworkInterface(),
    this.duration = Duration.zero,
    this.numTestRuns = 1,
    this.permissions = const [],
    this.recordScreen = true,
    this.captureTraffic = true,
    this.testConstellations = const [],
    this.hasAnalysis = false,
  });
  TestScenarioState.fromScenario(TestScenario scenario)
      : this(
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
          hasAnalysis: scenario.analysis != null,
        );

  final bool loading;
  final bool deviceFound;
  final String loadingInfo;
  final String applicationId;
  final String applicationName;
  final String name;
  final String fileDirectory;
  final String userInputRecord;
  bool get hasInputRecord => userInputRecord.isNotEmpty;
  final String device;
  final AndroidInputDevice deviceInput;
  final TsharkNetworkInterface networkInterface;
  final Duration duration;
  final int numTestRuns;
  final List<PermissionSetting> permissions;
  final bool recordScreen;
  final bool captureTraffic;
  final List<TestConstellation> testConstellations;
  final bool hasAnalysis;
  bool get canConfigure => !hasTests;
  bool get canRun => testConstellations.isNotEmpty;
  bool get hasTests => testConstellations.any((c) => c.tests.isNotEmpty);

  @override
  List<Object?> get props => [
        loading,
        deviceFound,
        loadingInfo,
        applicationId,
        applicationName,
        userInputRecord,
        device,
        deviceInput,
        networkInterface,
        name,
        fileDirectory,
        duration,
        numTestRuns,
        permissions,
        recordScreen,
        captureTraffic,
        testConstellations,
        hasAnalysis,
      ];

  TestScenarioState copyWith({
    bool? loading,
    bool? deviceFound,
    String? loadingInfo,
    String? applicationId,
    String? applicationName,
    String? userInputRecord,
    String? device,
    AndroidInputDevice? deviceInput,
    TsharkNetworkInterface? networkInterface,
    String? name,
    String? fileDirectory,
    Duration? duration,
    int? numTestRuns,
    List<PermissionSetting>? permissions,
    bool? recordScreen,
    bool? captureTraffic,
    List<TestConstellation>? testConstellations,
    bool? hasAnalysis,
  }) {
    return TestScenarioState(
      loading: loading ?? this.loading,
      deviceFound: deviceFound ?? this.deviceFound,
      loadingInfo: loadingInfo ?? this.loadingInfo,
      applicationId: applicationId ?? this.applicationId,
      applicationName: applicationName ?? this.applicationName,
      userInputRecord: userInputRecord ?? this.userInputRecord,
      device: device ?? this.device,
      deviceInput: deviceInput ?? this.deviceInput,
      networkInterface: networkInterface ?? this.networkInterface,
      name: name ?? this.name,
      fileDirectory: fileDirectory ?? this.fileDirectory,
      duration: duration ?? this.duration,
      numTestRuns: numTestRuns ?? this.numTestRuns,
      permissions: permissions ?? this.permissions,
      recordScreen: recordScreen ?? this.recordScreen,
      captureTraffic: captureTraffic ?? this.captureTraffic,
      testConstellations: testConstellations ?? this.testConstellations,
      hasAnalysis: hasAnalysis ?? this.hasAnalysis,
    );
  }
}
