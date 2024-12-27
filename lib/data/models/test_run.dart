
import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_run.g.dart';

@collection
class TestRun {
  TestRun({
    this.index = 0,
    this.screenRecordPath,
    this.pcapPath,
    this.startTimeInMs = 0,
    this.durationInMs = 0,
    this.packets = const [],
    this.connections = const [],
  });

  Id id = Isar.autoIncrement;
  int index;

  String? screenRecordPath;
  String? pcapPath;
  // TODO: Add startTime + Duration; make Analysis-Page for TestRuns
  int startTimeInMs;
  int durationInMs;
  bool get hasData =>
      screenRecordPath != null && screenRecordPath!.isNotEmpty ||
      pcapPath != null && pcapPath!.isNotEmpty;

  List<NetworkPacket> packets;
  List<NetworkConnection> connections;

  @ignore
  List<NetworkEndpoint>? endpoints;
}
