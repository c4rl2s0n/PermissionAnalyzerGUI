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

    DateTime startTime = DateTime.now();

    // record the input events
    _emit(state.copyWith(loadingInfo: "Recording user input..."));
    Process getEvents = await _adb.getEvents(
      duration: state.duration,
    );
    List<String> eventLines = [];
    getEvents.outLines.listen((data) {
      List<String> lines = data.split("\n");
      if(lines.firstOrNull?.startsWith("[") ?? false) {
        String line = lines.first;
        String eventPath = line.split("]")[1].split(":")[0].trim();
        if(eventLines.isEmpty) {
          Duration initialOffset = DateTime.now().difference(startTime);
          String timestampPart = line.split("]").first.split("[")[1].trim();
          double currentEventTimestamp = double.parse(timestampPart);
          double initialEventTimestamp = currentEventTimestamp - (initialOffset.inMicroseconds / 1000000);
          eventLines.add("[    $initialEventTimestamp] $eventPath: 0 0 0");
          //eventLines.add("[$initialEventTimestamp] ${state.deviceInput.path} 0 0 0");
        }
        eventLines.addAll(lines.where((l) => l.startsWith("[")));
      }

    });
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
    testScenario.userInputRecord = eventLines.join("\n");//await getEvents.outText;

    _emit(state.copyWith(
      loading: false,
      userInputRecord: testScenario.userInputRecord,
    ));

    storeScenario();
  }

  Future _runTest(TestConstellation constellation, String fileDirectory, int index, String testName,) async {
    String loadingInfoSuffix =
        "${constellation.abbreviation} ${constellation.blockedIPs.isNotEmpty ? "(${constellation.blockedIPs.length} blocked endpoints)" : ""} - $index";
    String pcapFilename = "traffic_${index.toString().padLeft(3, "0")}.pcap";
    // setup working directory to store capture files
    if (state.recordScreen || state.captureTraffic) {
      await Directory(fileDirectory).create(recursive: true);
    }
    Process? pcapProcess;

    // set all permissions according to test constellation
    _emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nAdjusting permissions"));
    await _setPermissions(constellation.permissions);

    // block endpoints according to test constellation
    _emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nSetup Firewall"));
    await _setupFirewall(constellation.blockedIPs);

    _emit(state.copyWith(
        loadingInfo: "$loadingInfoSuffix:\nRestart application"));
    // restart the application
    await _adb.stopApp(state.applicationId);
    await _adb.startApp(state.applicationId);

    int testStart = DateTime.now().millisecondsSinceEpoch;

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
    Process? userInputProcess;
    if(state.hasInputRecord) {
      userInputProcess = await _adb.shellProc([
        _settings.recorderDestinationPath,
        _settings.inputRecordDestinationPath,
      ]);
    }

    // let test run through
    for(int i=0; i<state.duration.inSeconds; i++){
      int remaining = state.duration.inSeconds - i;
      _emit(state.copyWith(loadingInfo: "$loadingInfoSuffix:\nRunning the test\n$remaining seconds remaining..."));
      await sleepSec(1);
    }
    userInputProcess?.kill();

    DateTime testRunEndTime = DateTime.timestamp();

    int durationInMs = DateTime.now().millisecondsSinceEpoch - testStart;
    // stop application
    await _adb.stopApp(state.applicationId);

    _emit(state.copyWith(loadingInfo: "$loadingInfoSuffix:\nFinish the test"));

    // Fetch all the generated files and store them in fileDirectory and db
    TestRun testRun = TestRun(
      index: index,
      name: testName, // TODO: Need identifier in adition to name (since constellations can have same name)
      startTimeInMs: testStart,
      durationInMs: durationInMs,
    );

    if (state.captureTraffic) {
      await pcapProcess?.exitCode;
      // store traffic data
      testRun.pcapPath = join(fileDirectory, pcapFilename);
      testRun.packets =
          await TrafficAnalyzer.extractPackets(_tshark, testRun.pcapPath!);
      testRun.connections =
          TrafficAnalyzer.getConnectionsFromPackets(testRun.packets, testRun: testRun);
      testRun.endpoints = TrafficAnalyzer.getEndpointsFromConnections(testRun.connections, filtered: false, endpointRepository: networkEndpointRepository,);
    }
    if (state.recordScreen) {
      // wait a short time for the device to properly store the screen record
      int delay =
          10 - DateTime.timestamp().difference(testRunEndTime).inSeconds;
      if (delay > 0) {
        await sleepSec(delay);
      }

      // get the screenrecord video from the device
      testRun.screenRecordPath = join(fileDirectory, "screenrecord_${index.toString().padLeft(3, "0")}.mp4");
      await _adb.pullFile(
        _videoStoragePathOnDevice,
        testRun.screenRecordPath!,
      );
    }

    if (testRun.hasData) {
      // No data to store...
      constellation.tests = <TestRun>[...constellation.tests, testRun];
    }

    // allow endpoints according to test constellation after running the test
    _emit(state.copyWith(loadingInfo: "$loadingInfoSuffix:\nRestore Firewall"));
    await _restoreFirewall(constellation.blockedIPs);

    storeScenario();
  }

  Future runTests() async {
    _emit(state.copyWith(
      loading: true,
      loadingInfo: "Preparing the environment for running the tests",
    ));

    if (state.name.isEmpty) setName("Unknown_${DateTime.now()}");

    // make sure working directory exists
    await Directory(_workingDirectory).create(recursive: true);

    // ensure adb is in root mode
    await _adb.root();
    
    if(state.hasInputRecord) {
      _setupInputRecorder();
    }

    _emit(state.copyWith(loadingInfo: "Run the tests"));
    // run the Test #numTestRuns times
    for (int i = 0; i < state.numTestRuns; i++) {
      // run the Test for each constellation
      for (TestConstellation constellation in testScenario.testConstellations) {
        int index = constellation.tests.length;
        // if there are already tests for this constellations, only perform the missing ones if numTestRuns was increased
        if(index > i) continue;

        // get the file-directory for the constellation
        String fileDirectory =
            join(_workingDirectory, constellation.uniqueIdentifier);

        // write the permissions for the constellation to a file
        if (i == 0) {
          _writeConstellationTxt(constellation, fileDirectory);
        }
        String testName = "${testScenario.applicationName}.${testScenario.name}.${constellation.displayName}.$index";
        // run the current test
        await _runTest(
          constellation,
          fileDirectory,
          index,
          testName,
        );
      }
    }

    _emit(state.copyWith(loadingInfo: "Finishing the tests"));
    _updateAnalysis();
    _emit(TestScenarioState.fromScenario(testScenario));
    _loadAppEndpoints();
  }

  Future _setupInputRecorder() async{
    // prepare the userinput_record file
    String uiRecordFilePath = join(_workingDirectory, "record.txt");
    File uiRecordFile = File(uiRecordFilePath);
    if (!await uiRecordFile.exists()) await uiRecordFile.create();
    uiRecordFile.writeAsString(state.userInputRecord);
    await _adb.pushFile(uiRecordFilePath, _settings.inputRecordDestinationPath);

    // push ui-replay binary to the device
    ByteData data = await rootBundle.load("assets/sendevent/${_settings.recorderVersion}");
    List<int> dataBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    String tmpPath = "${(await getTemporaryDirectory()).path}/mysendevent";
    await File(tmpPath).writeAsBytes(dataBytes, flush: true);
    await _adb.pushFile(tmpPath, _settings.recorderDestinationPath);
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
    permissionString += constellation.blockedEndpoints?.map((e) => e.name).join("\n") ?? "";
    await permissionsTxt.writeAsString(permissionString);
  }
}
