part of 'test_scenario_cubit.dart';

extension TestScenarioExecutor on TestScenarioCubit {
  Future recordScenario() async {
    _emit(state.copyWith(
      loading: true,
      userInputRecord: "",
      loadingInfo: "Recording the test scenario",
    ));

    // ensure adb is in root mode
    await _adb.root();

    // revoke all permissions
    _emit(state.copyWith(loadingInfo: "Revoking permissions"));
    for (var permission in testScenario.permissions) {
      await _adb.setPermission(
        applicationId: testScenario.applicationId,
        permission: permission.permission,
        granted: false,
      );
    }

    // restart the application
    _emit(state.copyWith(loadingInfo: "Restart application"));
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    await sleepSec(_startAppDelay);

    // record the input events
    _emit(state.copyWith(loadingInfo: "Recording user input..."));
    Process getEvents = await _adb.getEvents(
      devicePath: state.deviceInput.path,
      duration: state.duration,
    );
    for (int i = 0; i < state.duration.inSeconds; i++) {
      _emit(
        state.copyWith(
          loadingInfo:
              "Recording user input...\n${state.duration.inSeconds - i} seconds remaining",
        ),
      );
      await sleepSec(1);
    }
    await getEvents.exitCode;

    // stop the application
    _emit(state.copyWith(loadingInfo: "Stopping the application"));
    await _adb.stopApp(state.applicationId);

    // store the collected information (input events)
    _emit(state.copyWith(loadingInfo: "Storing the results"));
    testScenario.userInputRecord = await getEvents.outText;

    _emit(state.copyWith(
      loading: false,
      userInputRecord: testScenario.userInputRecord,
    ));

    _storeScenario();
  }

  Future _runTest(TestConstellation constellation, String fileDirectory) async {
    String loadingInfoSuffix =
        "${constellation.abbreviation} - ${basename(fileDirectory)}";
    String pcapFilename = "traffic.pcap";
    // setup working directory to store capture files
    if (state.recordScreen || state.captureTraffic) {
      await Directory(fileDirectory).create(recursive: true);
    }
    Process? pcapProcess;
    String? pcapJson;

    // set all permissions according to test constellation
    _emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nAdjusting permissions"));
    await _setPermissions(constellation.permissions);

    _emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nRestart application"));
    // restart the application
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    // await application to start
    await sleepSec(_startAppDelay);

    _emit(state.copyWith(loadingInfo: "$loadingInfoSuffix:\nRunning the test"));
    // setup screen recording
    if (state.recordScreen) {
      _adb.recordScreen(
        videoPath: _videoStoragePathOnDevice,
        duration: state.duration,
      );
    }

    // setup network sniffing
    if (state.captureTraffic) {
      pcapProcess = await _tshark.capture(
        pcapPath: join(fileDirectory, pcapFilename),
        interface: state.networkInterface.name,
        duration: state.duration,
      );
      // need to flush streams to avoid getting stuck
      pcapProcess.outLines.forEach((line) {});
      pcapProcess.errLines.forEach((_) {});
    }

    // replay user input
    Process userInputProcess = await _adb.shellProc([
      _settings.recorderDestinationPath,
      state.deviceInput.path,
      _settings.inputRecordDestinationPath,
    ]);

    // let test run through
    await sleep(state.duration);
    await userInputProcess.exitCode;
    DateTime testRunEndTime = DateTime.timestamp();

    // stop application
    await _adb.stopApp(state.applicationId);

    _emit(state.copyWith(loadingInfo: "$loadingInfoSuffix:\nFinish the test"));

    // Fetch all the generated files and store them in fileDirectory and db
    TestRun testRun = TestRun();

    if (state.captureTraffic) {
      await pcapProcess?.exitCode;
      // store traffic data
      testRun.pcapPath = join(fileDirectory, pcapFilename);
      testRun.packets =
          await TrafficAnalyzer.extractPackets(_tshark, testRun.pcapPath!);
      testRun.connections = TrafficAnalyzer.getConnectionsFromPackets(testRun.packets!);
    }
    if (state.recordScreen) {
      // wait a short time for the device to properly store the screen record
      int delay =
          10 - DateTime.timestamp().difference(testRunEndTime).inSeconds;
      if (delay > 0) {
        await sleepSec(delay);
      }

      // get the screenrecord video from the device
      testRun.screenRecordPath = join(fileDirectory, "screenrecord.mp4");
      await _adb.pullFile(
        _videoStoragePathOnDevice,
        testRun.screenRecordPath!,
      );
    }

    if (testRun.hasData) {
      constellation.tests = [...constellation.tests, testRun];
    }
    _storeScenario();
  }

  Future runTests() async {
    _emit(state.copyWith(
      loading: true,
      loadingInfo: "Preparing the environment for running the tests",
    ));

    if (state.name.isEmpty) setName("Unknown_${DateTime.now()}");

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

    _emit(state.copyWith(loadingInfo: "Run the tests"));
    // run the Test #numTestRuns times
    for (int i = 0; i < state.numTestRuns; i++) {
      // run the Test for each constellation
      for (var constellation in testScenario.testConstellations) {
        String fileDirectory =
            join(_workingDirectory, constellation.abbreviation);

        if (i == 0) {
          _writePermissionTxt(constellation, fileDirectory);
        }
        await _runTest(
          constellation,
          join(fileDirectory,
              "(${constellation.tests.length.toString().padLeft(3, "0")})"),
        );
      }
    }

    _emit(state.copyWith(
      loadingInfo: "Preparing the environment for running the tests",
    ));
    _updateAnalysis();
    _emit(TestScenarioState.fromScenario(testScenario));
  }

  void _updateAnalysis() {
    String constellationInfo(TestConstellation c) {
      String info = 'Permissions:\n';
      info += c.permissions
          .where((p) => p.state == PermissionState.granted)
          .map((p) => p.permission)
          .join("\t\t\n");
      return info;
    }

    for (var constellation in testScenario.testConstellations) {
      constellation.trafficGroup = TrafficGroup(
        name: constellation.abbreviation,
        info: constellationInfo(constellation),
        tags: [tConstellation],
        tests: List.of(constellation.tests),
      );
    }
    testScenario.testConstellations = List.of(testScenario.testConstellations);
    _storeScenario();
  }

  Future _writePermissionTxt(
    TestConstellation constellation,
    String fileDirectory,
  ) async {
    // write the current permission constellation to a file
    File permissionsTxt = File(join(fileDirectory, "permissions.txt"));
    if (!await permissionsTxt.exists()) {
      await permissionsTxt.create(recursive: true);
    }
    String permissionString = constellation.permissions
        .where((p) => p.state == PermissionState.granted)
        .map((p) => p.permission)
        .join("\n");
    await permissionsTxt.writeAsString(permissionString);
  }
}
