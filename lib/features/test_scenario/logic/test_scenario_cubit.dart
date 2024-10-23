import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

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
  int get _startAppDelay => 5;
  String get _videoStoragePathOnDevice => "/sdcard/out.mp4";

  AdbService? _adbService;
  AdbService get _adb {
    _adbService ??= AdbService(settingsCubit,
        device: state.testDevice.isNotEmpty ? state.testDevice : null);
    return _adbService!;
  }

  Future _initialize() async {
    //emit(state.copyWith(loading: true));
    if (_session.adbDevice.isEmpty) return;
    emit(state.copyWith(testDevice: _session.adbDevice));
    if(testScenario.permissions.isEmpty) {
      var permissions = await _adb.getApplicationPermissions(
          state.applicationId);
      testScenario.permissions = permissions
          .map((p) =>
          PermissionSetting(permission: p, state: PermissionState.revoked))
          .toList();
      emit(state.copyWith(permissions: List.of(testScenario.permissions)));
    }
    //emit(state.copyWith(loading: false));
  }

  void _storeScenario() {
    testScenarioRepository.updateTestScenario(testScenario);
  }

  void setName(String name) {
    testScenario.name = name;
    emit(state.copyWith(name: testScenario.name));
  }

  void setApplicationId(String appId) {
    testScenario.applicationId = appId;
    emit(state.copyWith(applicationId: testScenario.applicationId));
  }

  void setDuration(int seconds) {
    testScenario.durationInSeconds = seconds;
    emit(state.copyWith(duration: testScenario.duration));
  }

  void resetUserInput() {
    testScenario.userInputRecord = "";
    emit(state.copyWith(userInputRecord: testScenario.userInputRecord));
  }

  void setNumTestRuns(int numTestRuns) {
    testScenario.numTestRuns = numTestRuns;
    emit(state.copyWith(numTestRuns: testScenario.numTestRuns));
  }

  void togglePermissionState(String permission) {
    testScenario.permissions = testScenario.permissions
        .map((p) => p.permission == permission
            ? PermissionSetting(permission: permission, state: p.state.next)
            : p)
        .toList();
    // reset the testConstellations when permissions were changed
    testScenario.testConstellations = [];
    emit(state.copyWith(
      permissions: List.of(testScenario.permissions),
      testConstellations: List.of(testScenario.testConstellations),
    ));
  }

  void toggleRecordScreen() {
    testScenario.recordScreen = !testScenario.recordScreen;
    emit(state.copyWith(recordScreen: testScenario.recordScreen));
  }

  void toggleCaptureTraffic() {
    testScenario.captureTraffic = !testScenario.captureTraffic;
    emit(state.copyWith(captureTraffic: testScenario.captureTraffic));
  }

  Future setEventDevice(String dev, String? info) async {
    testScenario.inputDevice = dev;
    testScenario.inputDeviceInfo = info ?? "";
    emit(state.copyWith(
      inputDevice: testScenario.inputDevice,
      inputDeviceInfo: testScenario.inputDeviceInfo,
    ));
  }

  Future recordScenario() async {
    emit(state.copyWith(
      loading: true,
      userInputRecord: "",
      loadingInfo: "Recording the test scenario",
    ));

    // ensure adb is in root mode
    await _adb.root();

    // revoke all permissions
    emit(state.copyWith(
      loadingInfo: "Revoking permissions",
    ));
    for (var permission in testScenario.permissions) {
      await _adb.setPermission(
        applicationId: testScenario.applicationId,
        permission: permission.permission,
        granted: false,
      );
    }

    // restart the application
    emit(state.copyWith(
      loadingInfo: "Restart application",
    ));
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    await sleepSec(_startAppDelay);

    // record the input events
    emit(state.copyWith(
      loadingInfo: "Recording user input...",
    ));
    Process getEvents = await _adb.getEvents(
      devicePath: state.inputDevice,
      duration: state.duration,
    );
    for (int i = 0; i < state.duration.inSeconds; i++) {
      emit(
        state.copyWith(
          loadingInfo:
              "Recording user input...\n${state.duration.inSeconds - i} seconds remaining",
        ),
      );
      await sleepSec(1);
    }
    await getEvents.exitCode;

    // stop the application
    emit(state.copyWith(
      loadingInfo: "Stopping the application",
    ));
    await _adb.stopApp(state.applicationId);

    // store the collected information (input events)
    emit(state.copyWith(
      loadingInfo: "Storing the results",
    ));
    testScenario.userInputRecord = await getEvents.outText;
    emit(state.copyWith(
      loading: false,
      userInputRecord: testScenario.userInputRecord,
    ));
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

  Future _runTest(TestConstellation constellation, String fileDirectory) async {
    String loadingInfoSuffix = basename(fileDirectory);
    // setup working directory to store capture files
    if (state.recordScreen || state.captureTraffic) {
      await Directory(fileDirectory).create(recursive: true);
    }

    // set all permissions according to test constellation
    emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nAdjusting permissions"));
    await _setPermissions(constellation.permissions);

    emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nRestart application"));
    // restart the application
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    // await application to start
    await sleepSec(_startAppDelay);

    emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nRunning the test"));
    // setup screen recording
    if (state.recordScreen) {
      _adb.recordScreen(
        videoPath: _videoStoragePathOnDevice,
        duration: state.duration,
      );
    }

    // setup network sniffing
    if (state.captureTraffic) {
      // TODO: integrate tshark
    }

    // replay user input
    await _adb.shell([
      _settings.recorderDestinationPath,
      state.inputDevice,
      _settings.inputRecordDestinationPath,
    ]);

    // stop application
    await _adb.stopApp(state.applicationId);

    emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nFinishing the test"));

    // Fetch all the generated files and store them in fileDirectory and db
    TestRun testRun = TestRun();
    if (state.recordScreen) {
      // wait a short time for the device to properly store the screen record
      await sleepSec(10);

      // get the screenrecord video from the device
      testRun.screenRecordPath = join(fileDirectory, "screenrecord.mp4");
      await _adb.pullFile(
        _videoStoragePathOnDevice,
        testRun.screenRecordPath!,
      );
    }
    if (state.captureTraffic) {
      testRun.pcapPath = join(fileDirectory, "traffic.pcap");
      // TODO: eventually load the pcap to json and import to application?
    }

    if (testRun.hasData) {
      constellation.tests = [...constellation.tests, testRun];
    }
  }

  Future runTests() async {
    emit(state.copyWith(
      loading: true,
      loadingInfo: "Preparing the environment for running the tests",
    ));

    // make sure working directory exists
    await Directory(_workingDirectory).create(recursive: true);

    // prepare the userinput_record file
    String uiRecordFilePath = join(_workingDirectory, "record.txt");
    File uiRecordFile = File(uiRecordFilePath);
    if (!await uiRecordFile.exists()) await uiRecordFile.create();
    uiRecordFile.writeAsString(state.userInputRecord);

    // ensure adb is in root mode
    await _adb.root();

    // push ui-replay binary and record to device
    await _adb.pushFile(
        _settings.recorderPath, _settings.recorderDestinationPath);
    await _adb.pushFile(uiRecordFilePath, _settings.inputRecordDestinationPath);

    emit(state.copyWith(loadingInfo: "Run the tests"));
    for (var constellation in state.testConstellations) {
      String fileDirectory = join(
          _workingDirectory,
          constellation.permissions
              .where((c) => c.state == PermissionState.granted)
              .map((c) => permissionToShortcut(c.permission))
              .join("_"));
      // TODO: decide, run the same test multiple times, or iterate through all multiple times?
      for (int i = 0; i < state.numTestRuns; i++) {
        await _runTest(constellation, "${fileDirectory}_(${i.toString().padLeft(3,"0")})");
      }
    }

    emit(state.copyWith(
      loadingInfo: "Preparing the environment for running the tests",
    ));
    _storeScenario();
    emit(TestScenarioState.fromScenario(testScenario));
  }
}

class TestScenarioState extends Equatable {
  const TestScenarioState({
    this.loading = false,
    this.loadingInfo = "",
    this.testDevice = "",
    this.applicationId = "",
    this.applicationName = "",
    this.name = "",
    this.userInputRecord = "",
    this.inputDevice = "",
    this.inputDeviceInfo = "",
    this.duration = Duration.zero,
    this.numTestRuns = 1,
    this.permissions = const [],
    this.recordScreen = true,
    this.captureTraffic = true,
    this.testConstellations = const [],
  });
  TestScenarioState.fromScenario(TestScenario scenario)
      : this(
          userInputRecord: scenario.userInputRecord,
          applicationId: scenario.applicationId,
          applicationName: scenario.applicationName,
          inputDevice: scenario.inputDevice,
          inputDeviceInfo: scenario.inputDeviceInfo,
          name: scenario.name,
          duration: scenario.duration,
          permissions: List.of(scenario.permissions),
          recordScreen: scenario.recordScreen,
          captureTraffic: scenario.captureTraffic,
          testConstellations: List.of(scenario.testConstellations),
        );

  final bool loading;
  final String loadingInfo;
  final String testDevice;
  final String applicationId;
  final String applicationName;
  final String name;
  final String userInputRecord;
  bool get hasInputRecord => userInputRecord.isNotEmpty;
  final String inputDevice;
  final String inputDeviceInfo;
  final Duration duration;
  final int numTestRuns;
  final List<PermissionSetting> permissions;
  final bool recordScreen;
  final bool captureTraffic;
  final List<TestConstellation> testConstellations;
  bool get canConfigure => !hasTests;
  bool get canRun => hasInputRecord && testConstellations.isNotEmpty;
  bool get hasTests => testConstellations.any((c) => c.tests.isNotEmpty);

  @override
  List<Object?> get props => [
        loading,
        loadingInfo,
        testDevice,
        applicationId,
        applicationName,
        userInputRecord,
        inputDevice,
        inputDeviceInfo,
        name,
        duration,
        numTestRuns,
        permissions,
        recordScreen,
        captureTraffic,
        testConstellations,
      ];

  TestScenarioState copyWith({
    bool? loading,
    String? loadingInfo,
    String? testDevice,
    String? applicationId,
    String? applicationName,
    String? userInputRecord,
    String? inputDevice,
    String? inputDeviceInfo,
    String? name,
    Duration? duration,
    int? numTestRuns,
    List<PermissionSetting>? permissions,
    bool? recordScreen,
    bool? captureTraffic,
    List<TestConstellation>? testConstellations,
  }) {
    return TestScenarioState(
      loading: loading ?? this.loading,
      loadingInfo: loadingInfo ?? this.loadingInfo,
      testDevice: testDevice ?? this.testDevice,
      applicationId: applicationId ?? this.applicationId,
      applicationName: applicationName ?? this.applicationName,
      userInputRecord: userInputRecord ?? this.userInputRecord,
      inputDevice: inputDevice ?? this.inputDevice,
      inputDeviceInfo: inputDeviceInfo ?? this.inputDeviceInfo,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      numTestRuns: numTestRuns ?? this.numTestRuns,
      permissions: permissions ?? this.permissions,
      recordScreen: recordScreen ?? this.recordScreen,
      captureTraffic: captureTraffic ?? this.captureTraffic,
      testConstellations: testConstellations ?? this.testConstellations,
    );
  }
}
