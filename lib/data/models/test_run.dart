import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_run.g.dart';

@embedded
class TestRun {
  TestRun({
    this.screenRecordPath,
    this.pcapPath,
    this.packets = const [],
    this.connections = const [],
  });

  String? screenRecordPath;
  String? pcapPath;
  bool get hasData =>
      screenRecordPath != null && screenRecordPath!.isNotEmpty ||
      pcapPath != null && pcapPath!.isNotEmpty;

  List<NetworkPacket>? packets;
  List<TrafficConnection>? connections;
}
