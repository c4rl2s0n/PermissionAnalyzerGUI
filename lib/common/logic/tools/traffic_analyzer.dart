import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';

class TrafficAnalyzer {
  /// #############
  /// Get Endpoints
  /// #############

  static List<INetworkEndpoint> getEndpointsFromGroups(
    List<TrafficGroup> groups, {
    bool filtered = true,
  }) {
    List<INetworkEndpoint> endpoints = [];
    for (var group in groups) {
      // get all connections
      for(var endpoint in group.endpoints){
        if(endpoints.any((e) => e.id == endpoint.id)) continue;
        endpoints.add(endpoint);
      }
      // if (group.connections is List<ConnectionGroup>) {
      //   endpoints.addAll(getEndpointsFromConnectionGroups(
      //     group.connections as List<ConnectionGroup>,
      //     filtered: filtered,
      //   ).where((ce) => !endpoints.any((e) => e.id == ce.id)));
      // } else if (group.connections is List<NetworkConnection>) {
      //   endpoints.addAll(getEndpointsFromConnections(
      //     group.connections as List<NetworkConnection>,
      //     filtered: filtered,
      //   ).where((ce) => !endpoints.any((e) => e.id == ce.id)));
      // }
    }
    return endpoints;
    return endpoints.distinct;
  }

  static List<NetworkEndpoint> getEndpointsFromConnections(
    List<NetworkConnection> connections, {
    bool filtered = true,
    INetworkEndpointRepository? endpointRepository,
  }) {
    connections =
        (filtered ? getFilteredConnections(connections) : connections).toList();
    if (endpointRepository != null) {
      List<String> ips = connections
          .fold(<String>[], (all, con) => [...all, ...con.ips])
          .toList()
          .distinct;
      List<NetworkEndpoint> endpoints = endpointRepository.getAllByIp(ips);
      for (var connection in connections) {
        var endpoint =
            endpoints.where((e) => e.ip == connection.ip).firstOrNull;
        if (endpoint != null) connection.endpoint = endpoint;
      }
      return endpoints;
    }
    return connections.map((c) => c.endpoint).toList();
  }

  static List<EndpointGroup> getEndpointsFromConnectionGroups(
    List<ConnectionGroup> connections, {
    bool filtered = true,
  }) {
    connections =
        (filtered ? getFilteredConnections(connections) : connections).toList();
    return getGroupedConnections(connections).map((c) => c.endpoint).toList();
  }

  /// ###############
  /// Get Connections
  /// ###############

  static List<INetworkConnection> getConnectionsFromTrafficGroups(
    List<TrafficGroup> groups, {
    bool filtered = true,
    bool grouped = false,
  }) {
    Map<String, INetworkConnection> connections = {};
    for (var group in groups) {
      // get all connections
      for (var connection in group.connections) {

        String key = connection.endpoint.id; // "${connection.endpoint.ip}_${connection.protocols}";
        if (!connections.containsKey(key)) {
          connections[key] = connection.copy;
        } else {
          if (connections[key]! is NetworkConnection) {
            NetworkConnection con = connections[key]! as NetworkConnection;
            con.testRunCount += connection.testRunCount;
            con.packets.addAll(connection.packets);
          }
        }
      }
    }
    List<INetworkConnection> conList =
        _connectionMapToList(connections, filtered: filtered);
    if (grouped) conList = getGroupedConnections(conList);
    return conList;
  }

  static List<INetworkConnection> getConnectionsFromTestRuns(
    List<TestRun> tests, {
    bool filtered = true,
    bool grouped = false,
  }) {
    Map<String, NetworkConnection> connectionsMap = {};
    for (var test in tests) {
      for (NetworkConnection connection in test.connections) {
        if (!connectionsMap.containsKey(connection.flow)) {
          // create copy of connection
          connectionsMap[connection.flow] = connection.copy;
        } else {
          // aggregate connection
          NetworkConnection tc = connectionsMap[connection.flow]!;
          tc.packets.addAll(test.packets ?? []);
          tc.testRunCount++;
        }
      }
    }
    List<INetworkConnection> connections =
        _connectionMapToList(connectionsMap, filtered: filtered);
    if (grouped) {
      return getGroupedConnections(connections);
    }
    return connections;
  }

  static List<T> getFilteredConnections<T extends INetworkConnection>(
    List<T> connections,
  ) {
    return connections
        .where(
          (c) => !c.ips.any(
              (ip) => ip.startsWith("10.0.") || ip.startsWith("127.0.0.1")),
        )
        .toList();
  }

  static List<ConnectionGroup> getGroupedConnections(
    List<INetworkConnection> connections, {
    int nGroupedOctets = 1, // number of octets to group over
  }) {
    void addEndpoint(ConnectionGroup group, NetworkEndpoint endpoint) {
      if (!group.endpoint.endpoints.contains(endpoint)) {
        group.endpoint.endpoints.add(endpoint);
      }
    }

    Map<String, ConnectionGroup> connectionGroups = {};
    for (var connection in connections) {
      if (connection is ConnectionGroup) {
        // connection is already grouped
        connectionGroups[connection.endpoint.name] = connection;
        continue;
      }
      connection as NetworkConnection;
      // group by domain name
      var domain = connection.endpoint.domain;
      if (domain != null) {
        // create the ConnectionGroup if not yet exists
        if (!connectionGroups.containsKey(domain)) {
          connectionGroups[domain] = ConnectionGroup(
            endpoint: EndpointGroup(
                hostname: domain, endpoints: [connection.endpoint]),
            connections: [connection],
          );
        } else {
          // add connection to existing ConnectionGroup
          addEndpoint(connectionGroups[domain]!, connection.endpoint);
          connectionGroups[domain]!.connections.add(connection);
        }
      } else {
        // group by ipRange
        var ipRange = getIpRange(connection.endpoint.ip, nGroupedOctets: nGroupedOctets);
        // create the ConnectionGroup if not yet exists
        if (!connectionGroups.containsKey(ipRange)) {
          connectionGroups[ipRange] = ConnectionGroup(
            endpoint: EndpointGroup(
              endpoints: [connection.endpoint],
            ),
            connections: [connection],
          );
        } else {
          // add connection to existing ConnectionGroup
          addEndpoint(connectionGroups[ipRange]!, connection.endpoint);
          connectionGroups[ipRange]!.connections.add(connection);
        }
      }
    }

    return connectionGroups.values.toList();
  }

  static List<NetworkConnection> getConnectionsFromPackets(
    List<NetworkPacket> packets, {
    bool filtered = true,
  }) {
    Map<String, NetworkConnection> connections = {};
    for (var packet in packets) {
      if (!connections.containsKey(packet.dst)) {
        connections[packet.dst] = NetworkConnection(
          ip: packet.ipDst,
          port: packet.portDst,
          packets: [],
        );
      }
      if (!connections.containsKey(packet.src)) {
        connections[packet.src] = NetworkConnection(
          ip: packet.ipSrc,
          port: packet.portSrc,
          packets: [],
        );
      }

      // incoming packets
      connections[packet.dst]!.packets.add(packet);

      // outgoing packets
      connections[packet.src]!.packets.add(packet);
    }
    return _connectionMapToList(connections, filtered: filtered);
  }

  static List<T> _connectionMapToList<T extends INetworkConnection>(
    Map<dynamic, T> connections, {
    bool filtered = true,
  }) {
    List<T> connectionsList = connections.values.toList();
    if (filtered) {
      connectionsList = getFilteredConnections(connectionsList);
    }
    for (var connection in connectionsList.whereType<NetworkConnection>()) {
      connection.analyzePackets();
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
    String millis = parts[1].substring(0, 3);
    return int.parse("$seconds$millis");
  }

  /// #################
  /// Helper
  /// #################
  static String getIpRange(String ip, {int nGroupedOctets=1}){
    List<String> parts = ip.split(".");
    assert(parts.length == 4);
    String ipRange = "";
    for(int i=0;i<parts.length-nGroupedOctets;i++){
      ipRange += parts[i];
      if(i < parts.length-1) ipRange += ".";
    }
    for(int i=0;i<nGroupedOctets;i++){
      ipRange += "0";
      if(i<nGroupedOctets-1) ipRange += ".";
    }
    ipRange += "/${32-nGroupedOctets*8}";
    return ipRange;
  }
}
