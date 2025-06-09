import 'dart:async';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'exeution_module.dart';

class TrafficCaptureModule extends ExecutionModule {
  TrafficCaptureModule(
    this._tshark, {
    required this.fileDirectory,
    required this.pcapFilename,
    required this.networkInterface,
    super.startTime,
    super.duration,
  });

  final Tshark _tshark;
  late Process pcapProcess;
  String fileDirectory;
  String pcapFilename;
  String get pcapPath => join(fileDirectory, pcapFilename);

  TsharkNetworkInterface networkInterface;

  @override
  Future start() async {
    pcapProcess = await _tshark.capture(
      pcapPath: join(fileDirectory, pcapFilename),
      interface: networkInterface.name,
      duration: duration,
    );
    // need to flush streams to avoid getting stuck
    pcapProcess.outLines.forEach((line) {});
    pcapProcess.errLines.forEach((_) {});
  }

  @override
  Future stop([Object? argument]) async {
    if (duration == null) {
      pcapProcess.kill(ProcessSignal.sigint);
    } else {
      await pcapProcess.exitCode;
    }
    if (argument != null && argument is TestRun) {
      await _applyToTestRun(
        argument,
        networkEndpointRepository: Modular.get<INetworkEndpointRepository>(),
      );
    }
    super.stop();
  }

  Future _applyToTestRun(
    TestRun testRun, {
    INetworkEndpointRepository? networkEndpointRepository,
  }) async {
    // store traffic data
    testRun.pcapPath = join(fileDirectory, pcapFilename);
    testRun.packets =
        await TrafficAnalyzer.extractPackets(_tshark, testRun.pcapPath!);
    testRun.connections = TrafficAnalyzer.getConnectionsFromPackets(
      testRun.packets,
      testRun: testRun,
    );
    testRun.endpoints = TrafficAnalyzer.getEndpointsFromConnections(
      testRun.connections,
      filtered: false,
      endpointRepository: networkEndpointRepository,
    );
  }
}
