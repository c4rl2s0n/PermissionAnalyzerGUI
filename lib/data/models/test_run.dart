import 'dart:math';

import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/connection_group.dart';
import 'package:permission_analyzer_gui/features/analysis/models/endpoint_group.dart';

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
  }) {
    if (name.isEmpty) {
      this.name = "TestRun_$index";
    } else {
      this.name = name;
    }
  }

  Id id = Isar.autoIncrement;
  int index;

  late String name;
  String? screenRecordPath;
  String? pcapPath;
  int startTimeInMs;
  int durationInMs;
  bool get hasData =>
      screenRecordPath != null && screenRecordPath!.isNotEmpty ||
      pcapPath != null && pcapPath!.isNotEmpty;

  List<NetworkPacket> packets;
  List<NetworkConnection> connections;

  @ignore
  Map<String, List<INetworkConnection?>>? _connectionTimeline;
  @ignore
  Map<String, List<INetworkConnection?>> get connectionTimeline{
    if(_connectionTimeline != null) return _connectionTimeline!;
    return _loadConnectionTimeline();
  }

  Map<String, List<INetworkConnection?>> _loadConnectionTimeline() {
    List<INetworkConnection?> emptyList = List.generate((durationInMs / 1000).ceil(), (_) => null);
    String keyTotal = "Total";
    _connectionTimeline = {
      keyTotal: List.of(emptyList),
    };
    for(var con in connections){
      _connectionTimeline![con.ip] = List.of(emptyList);
    }
    int tsInSec = 0;
    List<NetworkPacket> packetsInFrame = [];
    for (var packet in packets) {
      // ignore packets without a timestamp (should not happen...)
      if (packet.timeInMs == null) {
        Logger.root
            .info("Skipping packet for timeline (missing timestamp)", packet);
        continue;
      }

      // get time of packet
      int packetTsInSec = ((packet.timeInMs! - startTimeInMs) / 1000).floor();
      // collect all packets within the current timeframe
      if (packetTsInSec == tsInSec) {
        packetsInFrame.add(packet);
        continue;
      }

      // get the connections for all packets within the current timeframe
      List<NetworkConnection> frameConnections =
          TrafficAnalyzer.getConnectionsFromPackets(
        packetsInFrame,
        testRun: this,
        filtered: false,
      );

      EndpointGroup totalEndpoint = EndpointGroup(endpoints: []);
      ConnectionGroup frameTotal = ConnectionGroup(endpoint: totalEndpoint, connections: [],);
      // put connection-frames to timeline
      for (var con in frameConnections) {
        if(!_connectionTimeline!.containsKey(con.ip)) continue;
        _connectionTimeline![con.ip]![tsInSec] = con;

        // aggregate for total connections
        totalEndpoint.endpoints.add(con.endpoint);
        frameTotal.connections.add(con);
      }
      _connectionTimeline![keyTotal]![tsInSec] = frameTotal;

      // go on with next packet in next timeframe
      tsInSec = max(0, packetTsInSec);
      packetsInFrame = [packet];
    }
    return _connectionTimeline!;
  }

  @ignore
  List<NetworkEndpoint>? endpoints;
}
