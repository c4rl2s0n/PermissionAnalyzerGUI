import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_run.g.dart';

@embedded
class TestRun {
  TestRun({
    this.screenRecordPath,
    this.pcapPath,
    this.packets = const [],
    List<TrafficConnection> connections = const [],
  }){
    this.connections = connections;
  }

  String? screenRecordPath;
  String? pcapPath;
  bool get hasData =>
      screenRecordPath != null && screenRecordPath!.isNotEmpty ||
      pcapPath != null && pcapPath!.isNotEmpty;

  List<NetworkPacket>? packets;
  late List<TrafficConnection> _connections;
  List<TrafficConnection> get connections => _connections;
  set connections(value) {
    _connections = value;
    endpoints = TrafficAnalyzer.getEndpointsFromConnections(connections);
  }
  late List<TrafficEndpoint> endpoints;
}
