import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_run.g.dart';

@collection
class TestRun {
  TestRun({
    this.index = 0,
    String name = "",
    this.screenRecordPath,
    this.pcapPath,
    this.startTimeInMs = 0,
    this.durationInMs = 0,
    this.packets = const [],
    this.connections = const [],
  }){
    if(name.isEmpty){
      this.name = "TestRun_$index";
    }else{
      this.name = name;
    }
  }

  Id id = Isar.autoIncrement;
  int index;

  late String name;
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
