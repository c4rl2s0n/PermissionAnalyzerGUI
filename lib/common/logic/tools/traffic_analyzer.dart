import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class TrafficAnalyzer {
  /// #############
  /// Get Endpoints
  /// #############

  static List<TrafficEndpoint> getEndpointsFromGroups(
    List<TrafficGroup> groups, {
    bool filtered = true,
  }) {
    List<TrafficEndpoint> endpoints = [];
    for (var group in groups) {
      // get all connections
      endpoints.addAll(getEndpointsFromConnections(
        group.connections,
        filtered: filtered,
      ));
    }
    return endpoints.distinct;
  }

  static List<TrafficEndpoint> getEndpointsFromConnections(
    List<TrafficConnection> connections, {
    bool filtered = true,
  }) {
    List<TrafficEndpoint> endpoints = [];
    endpoints.addAll(
      (filtered ? getFilteredConnections(connections) : connections)
          .where((c) => !endpoints.any((e) => e.name == c.endpoint!.name))
          .map((c) => c.endpoint!),
    );
    return endpoints.distinct;
  }

  /// ###############
  /// Get Connections
  /// ###############

  static List<TrafficConnection> getConnectionsFromTrafficGroups(
    List<TrafficGroup> groups, {
    bool filtered = true,
  }) {
    Map<String, TrafficConnection> connections = {};
    for (var group in groups) {
      // get all connections
      for (var connection in group.connections) {
        String key = "${connection.endpoint?.name}_${connection.protocols}";
        if (!connections.containsKey(key)) {
          connections[key] = connection.copy();
        } else {
          connections[key]!.testRunCount += connection.testRunCount;
          connections[key]!.inCount += connection.inCount;
          connections[key]!.outCount += connection.outCount;
          connections[key]!.inBytes += connection.inBytes;
          connections[key]!.outBytes += connection.outBytes;
        }
      }
    }
    return _connectionMapToList(connections, filtered: filtered);
  }

  static List<TrafficConnection> getConnectionsFromTestRuns(
    List<TestRun> tests, {
    bool filtered = true,
  }) {
    Map<String, TrafficConnection> connections = {};
    for (var test in tests) {
      for (TrafficConnection connection in test.connections ?? []) {
        if (!connections.containsKey(connection.flow)) {
          // create copy of connection
          connections[connection.flow] = connection.copy();
        } else {
          // aggregate connection
          TrafficConnection tc = connections[connection.flow]!;
          tc.testRunCount++;
          tc.outCount += connection.outCount;
          tc.inCount += connection.inCount;
          tc.outBytes += connection.outBytes;
          tc.inBytes += connection.inBytes;
        }
      }
    }
    return _connectionMapToList(connections, filtered: filtered);
  }

  static List<TrafficConnection> getFilteredConnections(
    List<TrafficConnection> connections,
  ) {
    return connections
        .where(
          (c) =>
              c.endpoint != null &&
              !c.endpoint!.ip.startsWith("10.0.") &&
              !c.endpoint!.ip.startsWith("127.0.0.1"),
        )
        .toList();
  }

  static List<TrafficConnection> getConnectionsFromPackets(
    List<NetworkPacket> packets, {
    bool filtered = true,
  }) {
    Map<String, TrafficConnection> connections = {};
    for (var packet in packets) {
      if (!connections.containsKey(packet.dst)) {
        connections[packet.dst] = TrafficConnection(
          endpoint: TrafficEndpoint(
            ip: packet.ipDst,
            port: packet.portDst,
          ),
          protocols: packet.protocols,
        );
      }
      if (!connections.containsKey(packet.src)) {
        connections[packet.src] = TrafficConnection(
          endpoint: TrafficEndpoint(
            ip: packet.ipSrc,
            port: packet.portSrc,
          ),
          protocols: packet.protocols,
        );
      }
      // incoming packets
      connections[packet.dst]!.inCount++;
      connections[packet.dst]!.inBytes += packet.size;

      // outgoing packets
      connections[packet.src]!.outCount++;
      connections[packet.src]!.outBytes += packet.size;
    }
    return _connectionMapToList(connections, filtered: filtered);
  }

  static List<TrafficConnection> _connectionMapToList(
    Map<dynamic, TrafficConnection> connections, {
    bool filtered = true,
  }) {
    List<TrafficConnection> connectionsList = connections.values.toList();
    if (filtered) {
      connectionsList = getFilteredConnections(connectionsList);
    }
    return connectionsList;
  }

  /// #################
  /// Packet Extraction
  /// #################

  static Future<List<NetworkPacket>> extractPackets(
      Tshark tshark, String pcapFilePath) async {
    List<dynamic>? packetList = await tshark.pcapFieldsToJson(
      pcapFile: pcapFilePath,
      fields: [
        'frame.time_epoch',
        'frame.len',
        'frame.protocols',
        'ip.src',
        'ip.dst',
        'tcp.srcport',
        'tcp.dstport',
        'udp.srcport',
        'udp.dstport',
      ],
    );
    // TODO: udp port not extracted
    if (packetList == null) return [];
    List<NetworkPacket> packets = [];
    for (var entry in packetList) {
      try {
        // extract relevant data
        Map<String, dynamic> packetData =
            entry['_source']['layers'] as Map<String, dynamic>;
        packets.add(_getPacketFromMap(packetData));
      } catch (_) {}
    }
    return packets;
  }

  static NetworkPacket _getPacketFromMap(Map<String, dynamic> packetData) {
    // frame info
    int timeInMs =
        _getTimestampFromPacket(packetData['frame.time_epoch'].first as String);
    int size = int.parse(packetData['frame.len'].first);
    String protocols = packetData['frame.protocols'].first;

    // ip info
    String ipSrc = packetData['ip.src'].first;
    String ipDst = packetData['ip.dst'].first;

    // tcp / udp info
    int? portSrc;
    int? portDst;
    if (protocols.contains('tcp')) {
      portSrc = int.parse(packetData['tcp.srcport'].first);
      portDst = int.parse(packetData['tcp.dstport'].first);
    } else if (packetData.keys.contains('udp')) {
      portSrc = int.parse(packetData['udp.srcport'].first);
      portDst = int.parse(packetData['udp.dstport'].first);
    }

    return NetworkPacket(
      ipSrc: ipSrc,
      portSrc: portSrc,
      ipDst: ipDst,
      portDst: portDst,
      protocols: protocols,
      timeInMs: timeInMs,
      size: size,
    );
  }

  static int _getTimestampFromPacket(String timeEpoch) {
    List<String> parts = timeEpoch.split('.');
    String seconds = parts[0];
    String millis = parts[1].substring(0, 4);
    return int.parse("$seconds$millis");
  }
}
