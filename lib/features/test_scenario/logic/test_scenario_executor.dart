part of 'test_scenario_cubit.dart';

extension TestScenarioExecutor on TestScenarioCubit {
  Future recordScenario() async {
    _emitLoading(state.copyWith(
      loading: true,
      userInputRecord: "",
      loadingInfo: "Recording the test scenario",
    ));

    // ensure adb is in root mode
    await _adb.root();

    // revoke all permissions
    _emitLoading(state.copyWith(loadingInfo: "Revoking permissions"));
    for (var permission in testScenario.permissions) {
      await _adb.setPermission(
        applicationId: testScenario.applicationId,
        permission: permission.permission,
        granted: false,
      );
    }

    // restart the application
    _emitLoading(state.copyWith(loadingInfo: "Restart application"));
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    // record the input events
    var recorder = InputRecordingModule(
      adb: _adb,
      duration: state.duration,
    );

    _emitLoading(state.copyWith(loadingInfo: "Recording user input..."));
    await recorder.start();

    for (int i = 0; i < state.duration.inSeconds; i++) {
      _emitLoading(state.copyWith(
          loadingInfo:
              "Recording user input...\n${state.duration.inSeconds - i} seconds remaining"));
      await sleepSec(1);
    }

    await recorder.stop();

    // stop the application
    _emitLoading(state.copyWith(loadingInfo: "Stopping the application"));
    await _adb.stopApp(state.applicationId);

    // store the collected information (input events)
    _emitLoading(state.copyWith(loadingInfo: "Storing the results"));
    testScenario.userInputRecord = recorder.eventLines.join("\n");

    _emitLoading(state.copyWith(
      loading: false,
      userInputRecord: testScenario.userInputRecord,
    ));

    storeScenario();
  }

  Future<List<ExecutionModule>> _prepareExecutionModules({
    required String fileDirectory,
    required int index,
    required Duration? duration,
    required DateTime testStart,
  }) async {
    List<ExecutionModule> modules = [];

    // setup working directory to store capture files
    if (state.recordScreen || state.captureTraffic) {
      await Directory(fileDirectory).create(recursive: true);
    }

    // setup network sniffing
    if (state.captureTraffic) {
      String pcapFilename = "traffic_${index.toString().padLeft(3, "0")}.pcap";
      modules.add(TrafficCaptureModule(
        _tshark,
        fileDirectory: fileDirectory,
        pcapFilename: pcapFilename,
        networkInterface: state.networkInterface,
        startTime: testStart,
      ));
    }

    // setup screen recording
    if (state.recordScreen) {
      modules.add(ScreenRecordModule(_adb, duration: state.duration));
    }

    // replay user input
    if (state.hasInputRecord) {
      modules.add(InputReplayModule(_adb, _settings));
    }

    return modules;
  }

  Future _startExecutionModules(List<ExecutionModule> modules) async {
    for (var module in modules) {
      await module.start();
    }
  }

  Future _stopExecutionModules(
    List<ExecutionModule> modules, {
    required TestRun testRun,
    required String fileDirectory,
    required int index,
    required DateTime testRunEndTime,
  }) async {
    for (var module in modules) {
      switch (module.runtimeType) {
        case const (TrafficCaptureModule):
          await module.stop(testRun);
          break;
        case const (ScreenRecordModule):
          await module.stop(ScreenRecordModuleStopArgument(
            fileDirectory,
            index,
            testRun,
            testRunEndTime,
          ));
          break;
        case _:
          await module.stop();
          break;
      }
    }
  }

  Future _runTest(
    TestConstellation constellation,
    String fileDirectory,
    int index,
    String testName,
  ) async {
    String loadingInfoSuffix =
        "${constellation.abbreviation} ${constellation.blockedIPs.isNotEmpty ? "(${constellation.blockedIPs.length} blocked endpoints)" : ""} - $index";

    // set all permissions according to test constellation
    _emitLoading(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nAdjusting permissions"));
    await _setPermissions(constellation.permissions);

    // block endpoints according to test constellation
    _emitLoading(
        state.copyWith(loadingInfo: "$loadingInfoSuffix:\nSetup Firewall"));
    await _setupFirewall(constellation.blockedIPs);

    _emitLoading(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nRestart application"));

    // stop the application (in case it is running)
    await _adb.stopApp(state.applicationId);

    // timestamp of test start
    DateTime testStart = DateTime.now();

    // prepare execution modules
    var executionModules = await _prepareExecutionModules(
      fileDirectory: fileDirectory,
      index: index,
      duration: state.duration,
      testStart: testStart,
    );

    // start the application
    await _adb.startApp(state.applicationId);

    // start all modules
    await _startExecutionModules(executionModules);

    // let test run through
    for (int i = 0; i < state.duration.inSeconds; i++) {
      int remaining = state.duration.inSeconds - i;
      _emitLoading(state.copyWith(
          loadingInfo:
              "$loadingInfoSuffix:\nRunning the test\n$remaining seconds remaining..."));
      await sleepSec(1);
    }

    DateTime testRunEndTime = DateTime.timestamp();

    int durationInMs = DateTime.now().millisecondsSinceEpoch -
        testStart.millisecondsSinceEpoch;
    // stop application
    await _adb.stopApp(state.applicationId);

    _emitLoading(
        state.copyWith(loadingInfo: "$loadingInfoSuffix:\nFinish the test"));

    // Fetch all the generated files and store them in fileDirectory and db
    TestRun testRun = TestRun(
      index: index,
      // TODO: Need identifier in adition to name (since constellations can have same name)
      name: testName,
      startTimeInMs: testStart.millisecondsSinceEpoch,
      durationInMs: durationInMs,
    );

    await _stopExecutionModules(
      executionModules,
      testRun: testRun,
      fileDirectory: fileDirectory,
      index: index,
      testRunEndTime: testRunEndTime,
    );

    if (testRun.hasData) {
      constellation.tests = <TestRun>[...constellation.tests, testRun];
    }

    // allow endpoints according to test constellation after running the test
    _emitLoading(
        state.copyWith(loadingInfo: "$loadingInfoSuffix:\nRestore Firewall"));
    await _restoreFirewall(constellation.blockedIPs);

    storeScenario();
  }

  Future runTests() async {
    _emitLoading(state.copyWith(
      loading: true,
      loadingInfo: "Preparing the environment for running the tests",
    ));

    if (state.name.isEmpty) setName("Unknown_${DateTime.now()}");

    // make sure working directory exists
    await Directory(_workingDirectory).create(recursive: true);

    // ensure adb is in root mode
    await _adb.root();

    if (state.hasInputRecord) {
      _setupInputRecorder();
    }

    _emitLoading(state.copyWith(loadingInfo: "Run the tests"));
    // run the Test #numTestRuns times
    for (int i = 0; i < state.numTestRuns; i++) {
      // run the Test for each constellation
      for (TestConstellation constellation in testScenario.testConstellations) {
        int index = constellation.tests.length;
        // if there are already tests for this constellations, only perform the missing ones if numTestRuns was increased
        if (index > i) continue;

        // get the file-directory for the constellation
        String fileDirectory =
            join(_workingDirectory, constellation.uniqueIdentifier);

        // write the permissions for the constellation to a file
        if (i == 0) {
          _writeConstellationTxt(constellation, fileDirectory);
        }
        String testName =
            "${testScenario.applicationName}.${testScenario.name}.${constellation.displayName}.$index";
        // run the current test
        await _runTest(
          constellation,
          fileDirectory,
          index,
          testName,
        );
      }
    }

    _emitLoading(state.copyWith(loadingInfo: "Finishing the tests"));
    _updateAnalysis();
    //_emit(TestScenarioState.fromScenario(testScenario));
    _loadAppEndpoints();
    _emitLoading(state.copyWith(loading: false));
  }

  Future _setupInputRecorder() async {
    // prepare the userinput_record file
    String uiRecordFilePath = join(_workingDirectory, "record.txt");
    File uiRecordFile = File(uiRecordFilePath);
    if (!await uiRecordFile.exists()) await uiRecordFile.create();
    uiRecordFile.writeAsString(state.userInputRecord);
    await _adb.pushFile(uiRecordFilePath, _settings.inputRecordDestinationPath);

    // push ui-replay binary to the device
    ByteData data =
        await rootBundle.load("assets/sendevent/${_settings.recorderVersion}");
    List<int> dataBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    String tmpPath = "${(await getTemporaryDirectory()).path}/mysendevent";
    await File(tmpPath).writeAsBytes(dataBytes, flush: true);
    await _adb.pushFile(tmpPath, _settings.recorderDestinationPath);
    await _adb.shell(["chmod", "+x", _settings.recorderDestinationPath]);
  }

  void _updateAnalysis() {
    testScenario.testConstellations = List.of(testScenario.testConstellations);
    storeScenario();
  }

  Future _writeConstellationTxt(
    TestConstellation constellation,
    String fileDirectory,
  ) async {
    // write the current permission constellation to a file
    File permissionsTxt = File(join(fileDirectory, "constellation.txt"));
    if (!await permissionsTxt.exists()) {
      await permissionsTxt.create(recursive: true);
    }
    String permissionString = "Granted Permissions:\n";
    permissionString = constellation.permissions
        .where((p) => p.state == PermissionState.granted)
        .map((p) => p.permission)
        .join("\n");
    permissionString += "\n\nBlocked Endpoints:\n";
    permissionString +=
        constellation.blockedEndpoints?.map((e) => e.name).join("\n") ?? "";
    await permissionsTxt.writeAsString(permissionString);
  }
}
