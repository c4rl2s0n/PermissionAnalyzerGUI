import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/exeution_module.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/input_recording_module.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/input_replay_module.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/screen_record_module.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/execution_modules/traffic_capture_module.dart';

part 'test_scenario_cubit.freezed.dart';
part 'test_scenario_executor.dart';

class TestScenarioCubit extends KeyboardReplayCubit<TestScenarioState> {
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

  List<NetworkEndpoint> applicationEndpoints = [];

  String get _workingDirectory => join(
        _settings.workingDirectory,
        state.applicationId,
        state.name,
      );


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

  StreamSubscription? sessionListener;

  void _emit(
    TestScenarioState state, {
    bool shouldReplay = true,
    bool? dataChanges,
  }) =>
      (dataChanges ?? false)
          ? emit(state.copyWith(
              shouldReplay: shouldReplay,
              hasChanges: true,
            ))
          : emit(state.copyWith(
              shouldReplay: shouldReplay,
            ));

  void _emitLoading(TestScenarioState state) =>
      _emit(state, shouldReplay: false);

  @override
  bool shouldReplay(TestScenarioState state) => state.shouldReplay;

  @override
  Future<void> close() async {
    await super.close();
    await sessionListener?.cancel();
  }

  Future _initialize() async {
    _loadAppEndpoints();
    sessionListener = sessionCubit.stream.listen((_) => checkDevice());
    if (_settings.tsharkPath.isEmpty) {
      testScenario.captureTraffic = false;
      _emit(state.copyWith(captureTraffic: testScenario.captureTraffic));
    }
    checkDevice();
    clearHistory();
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
    _emit(TestScenarioState.fromScenario(
      testScenario,
      firewallSettings: applicationEndpoints
          .map((e) => FirewallSetting(ip: e.ip, endpoint: e))
          .toList(),
    ));
    clearHistory();
  }

  Future delete() async {
    testScenarioRepository.delete(testScenario.id);
    if (state.name.notEmpty) {
      await _clearFiles();
    }
  }

  Future _clearFiles() async {
    Directory fileDir = Directory(_workingDirectory);
    if (await fileDir.exists()) {
      await fileDir.delete(recursive: true);
    }
  }

  Future _loadAppPermissions() async {
    var permissions =
        await _adb.getOptionalApplicationPermissions(state.applicationId);
    testScenario.permissions = permissions
        .map((p) =>
            PermissionSetting(permission: p, state: PermissionState.revoked))
        .toList();

    // in case an empty testConstellation was created, set the permissions
    for (var constellation in state.testConstellations) {
      constellation.permissions = List.of(testScenario.permissions);
    }
    _emitLoading(
        state.copyWith(permissions: List.of(testScenario.permissions)));
  }

  void _loadAppEndpoints() {
    applicationEndpoints =
        networkEndpointRepository.getByApplication(testScenario.applicationId);
    _emitLoading(state.copyWith(
        firewallSettings: applicationEndpoints
            .map((e) => FirewallSetting(ip: e.ip, endpoint: e))
            .toList()));
  }

  bool get hasChanges => canUndo;

  void storeScenario() {
    if (!hasChanges) return;
    testScenarioRepository.update(testScenario);
    emit(state.copyWith(hasChanges: false));
    clearHistory();
  }

  void setName(String name) {
    testScenario.name = name;
    _emit(state.copyWith(name: testScenario.name), dataChanges: true);
  }

  void setDuration(int seconds) {
    // emit twice to ensure ui is updated
    testScenario.durationInSeconds = seconds;
    bool valid = !(state.recordScreen && seconds > 180);
    _emit(state.copyWith(duration: testScenario.duration),
        shouldReplay: valid, dataChanges: true);
    if (!valid) {
      seconds = 180;
      testScenario.durationInSeconds = seconds;
      _emit(state.copyWith(duration: testScenario.duration));
      SnackBarFactory.showWarningSnackbar(
          "When using screen recording, the maximum duration is 180 seconds.");
    }
  }

  void resetUserInput() {
    testScenario.userInputRecord = "";
    _emit(state.copyWith(userInputRecord: testScenario.userInputRecord),
        dataChanges: true);
  }

  void setNumTestRuns(int numTestRuns) {
    testScenario.numTestRuns = numTestRuns;
    _emit(state.copyWith(numTestRuns: testScenario.numTestRuns),
        dataChanges: true);
  }

  void _togglePermissionState(String permission) {
    testScenario.permissions = testScenario.permissions
        .map((p) => p.permission == permission
            ? PermissionSetting(permission: permission, state: p.state.next)
            : p)
        .toList();
  }

  void _updatePermissionState() {
    _emit(state.copyWith(permissions: List.of(testScenario.permissions)));
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

  List<FirewallSetting> _toggleFirewallState(
      List<FirewallSetting> firewallSettings, String ip) {
    return firewallSettings.map((f) => f.ip == ip ? f.toggle : f).toList();
  }

  void toggleFirewallState(String ip) {
    _emit(state.copyWith(
        firewallSettings: _toggleFirewallState(state.firewallSettings, ip)));
  }

  bool _ipInRange(String ipA, String ipB, int nParts) {
    assert(nParts <= 4);
    List<String> a = ipA.split(".");
    List<String> b = ipB.split(".");
    for (int i = 0; i < nParts; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void setFirewallStateIpRange(String ip, int nParts, bool blocked) {
    List<FirewallSetting> settings = state.firewallSettings
        .map((f) =>
            f.blocked != blocked && _ipInRange(f.ip, ip, nParts) ? f.toggle : f)
        .toList();
    _emit(state.copyWith(firewallSettings: settings));
  }

  void setFirewallStateByDomain(String domain, bool blocked) {
    List<FirewallSetting> settings = state.firewallSettings
        .map((f) => f.blocked != blocked && f.endpoint?.domainString == domain
            ? f.toggle
            : f)
        .toList();
    _emit(state.copyWith(firewallSettings: settings));
  }

  void toggleAllFirewallStates() {
    List<FirewallSetting> firewallSettings = [];
    for (var fw in state.firewallSettings) {
      firewallSettings.add(fw.toggle);
    }
    _emit(state.copyWith(firewallSettings: firewallSettings));
  }

  void resetAllFirewallStates() {
    List<FirewallSetting> firewallSettings =
        state.firewallSettings.map((f) => f.reset).toList();
    _emit(state.copyWith(firewallSettings: firewallSettings));
  }

  void toggleRecordScreen() {
    testScenario.recordScreen = !testScenario.recordScreen;
    _emit(state.copyWith(recordScreen: testScenario.recordScreen),
        dataChanges: true);
    setDuration(testScenario.durationInSeconds);
  }

  void toggleCaptureTraffic() {
    testScenario.captureTraffic = !testScenario.captureTraffic;
    _emit(state.copyWith(captureTraffic: testScenario.captureTraffic),
        dataChanges: true);
  }

  Future setEventInputDevice(AndroidInputDevice deviceInput) async {
    testScenario.deviceInput = deviceInput;
    _emit(state.copyWith(deviceInput: deviceInput), dataChanges: true);
  }

  Future setNetworkInterface(TsharkNetworkInterface interface) async {
    testScenario.networkInterface = interface;
    _emit(state.copyWith(networkInterface: interface), dataChanges: true);
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
    Map<String, NetworkEndpoint?> blockedIps = {};
    for (var f in state.firewallSettings.where((f) => f.blocked)) {
      blockedIps[f.ip] = f.endpoint;
    }
    // set one constellations with all testing permissions revoked for reference
    TestConstellation c = TestConstellation(
      permissions: testScenario.permissions
          .map((p) => PermissionSetting(
              permission: p.permission,
              state: p.state == PermissionState.granted
                  ? PermissionState.granted
                  : PermissionState.revoked))
          .toList(),
      blockedIPs: List.of(blockedIps.keys),
      displayNameAppendix: blockedIps.keys.isNotEmpty ? "withFirewall" : "",
    );
    List<TestConstellation> constellations = [c];
    // create all the constellations where permissions are set to testing-state (test with granted and revoked)
    for (var p in testScenario.permissions
        .where((p) => p.state == PermissionState.test)) {
      constellations.add(
        TestConstellation(
          permissions: _getPermissionConstellation(p),
          blockedIPs: List.of(blockedIps.keys),
          displayNameAppendix: blockedIps.keys.isNotEmpty ? "withFirewall" : "",
        ),
      );
    }
    // only add constellations that do not yet exist
    List<TestConstellation> newConstellations = constellations
        .where((tc) =>
            !testScenario.testConstellations.any((tstc) => tc.equalTo(tstc)))
        .toList();

    // add list of endpoints after creating constellations with plain IP
    for (var c in newConstellations) {
      c.blockedEndpoints =
          c.blockedIPs.map((ip) => blockedIps[ip]).nonNulls.toList();
    }
    testScenario.testConstellations = [
      ...testScenario.testConstellations,
      ...newConstellations,
    ];
    // returns the number of constellations that already existed
    int nDuplicates = constellations.length - newConstellations.length;
    bool? dataChanges;
    if (nDuplicates > 0) dataChanges = true;
    _emit(
      state.copyWith(testConstellations: testScenario.testConstellations),
      dataChanges: dataChanges,
    );
    return nDuplicates;
  }

  void removeConstellation(TestConstellation tc) {
    List<TestConstellation> constellations =
        testScenario.testConstellations.toList();
    constellations.remove(tc);
    testScenario.testConstellations = constellations;
    _emit(
      state.copyWith(testConstellations: testScenario.testConstellations),
      dataChanges: true,
    );
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

  Future _setupFirewall(List<String> blockedIPs) async {
    for (var ip in blockedIPs) {
      await _adb.blockIP(ip: ip);
    }
  }

  Future _restoreFirewall(List<String> blockedIPs) async {
    for (var ip in blockedIPs) {
      await _adb.allowIP(ip: ip);
    }
  }
}

@freezed
class TestScenarioState with _$TestScenarioState {
  const TestScenarioState._();

  const factory TestScenarioState({
    required bool loading,
    required bool shouldReplay,
    required bool hasChanges,
    required String loadingInfo,
    required String applicationId,
    required String applicationName,
    required String name,
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
    required List<FirewallSetting> firewallSettings,
  }) = _TestScenarioState;

  factory TestScenarioState.empty() => const TestScenarioState(
        loading: false,
        shouldReplay: true,
        hasChanges: false,
        loadingInfo: "",
        applicationId: "",
        applicationName: "",
        name: "",
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
        firewallSettings: [],
      );
  factory TestScenarioState.fromScenario(
    TestScenario scenario, {
    List<FirewallSetting> firewallSettings = const [],
  }) =>
      TestScenarioState(
        loading: false,
        shouldReplay: true,
        hasChanges: false,
        loadingInfo: "",
        userInputRecord: scenario.userInputRecord,
        applicationId: scenario.applicationId,
        applicationName: scenario.applicationName,
        device: scenario.device,
        deviceInput: scenario.deviceInput,
        networkInterface: scenario.networkInterface,
        name: scenario.name,
        duration: scenario.duration,
        numTestRuns: scenario.numTestRuns,
        permissions: List.of(scenario.permissions),
        recordScreen: scenario.recordScreen,
        captureTraffic: scenario.captureTraffic,
        testConstellations: List.of(scenario.testConstellations),
        firewallSettings: List.of(firewallSettings),
      );
  bool get hasInputRecord => userInputRecord.isNotEmpty;
  bool get hasTests => testConstellations.any((c) => c.testIds.isNotEmpty);
  int get numTestsPerformed =>
      testConstellations.map((tc) => tc.tests.length).toList().max as int;
}
