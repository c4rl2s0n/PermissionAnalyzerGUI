import 'package:permission_analyzer_gui/data/data.dart';

import 'tshark.dart';

class TrafficAnalyzer {
  static List<TrafficConnection> getConnections(List<NetworkPacket> packets) {
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
    return connections.values.toList();
  }

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
