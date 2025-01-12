import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
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
      for (var endpoint in group.endpoints) {
        if (endpoints.any((e) => e.id == endpoint.id)) continue;
        endpoints.add(endpoint);
      }
    }
    return endpoints;
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
    List<TestRun> tests = [];
    for (var group in groups) {
      tests.addAll(group.tests);
    }
    return getConnectionsFromTestRuns(tests,
        filtered: filtered, grouped: grouped);
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
          connectionsMap[connection.flow]!.testRuns = [test];
        } else {
          // aggregate connection
          NetworkConnection tc = connectionsMap[connection.flow]!;
          tc.packets.addAll(
              test.packets.where((p) => p.ipSrc == tc.ip || p.ipDst == tc.ip));
          if (!tc.testRuns.any((tr) => tr.id == test.id)) {
            tc.testRuns.add(test);
          }
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
    return connections.where((c) => !c.ips.any(_shouldFilterIp)).toList();
  }

  static List<NetworkPacket> getFilteredPackets(
    List<NetworkPacket> packets,
  ) {
    return packets
        .where((p) => !(_shouldFilterIp(p.ipDst) && _shouldFilterIp(p.ipSrc)))
        .toList();
  }

  static bool _shouldFilterIp(String ip) =>
      ip.startsWith("10.0.") || ip.startsWith("127.0.0.1");

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
        connectionGroups[connection.endpoint.displayName] = connection;
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
        var ipRange =
            getIpRange(connection.endpoint.ip, nGroupedOctets: nGroupedOctets);
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
    TestRun? testRun,
    bool filtered = true,
  }) {
    Map<String, NetworkConnection> connections = {};
    for (var packet in packets) {
      if (!connections.containsKey(packet.dst)) {
        connections[packet.dst] = NetworkConnection(
            ip: packet.ipDst,
            port: packet.portDst,
            packets: [],
            testRuns: testRun != null ? [testRun] : [],
            serverName: packet.serverName,
        );
      }
      if (!connections.containsKey(packet.src)) {
        connections[packet.src] = NetworkConnection(
            ip: packet.ipSrc,
            port: packet.portSrc,
            packets: [],
            testRuns: testRun != null ? [testRun] : [],
          serverName: packet.serverName,
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
        'tls.handshake.session_id',
        'tls.handshake.extensions_server_name',
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
        packets.add(_getPacketFromMap(packetData, allPackets: packets));
      } catch (_) {}
    }
    return TrafficAnalyzer.getFilteredPackets(packets);
  }

  static NetworkPacket _getPacketFromMap(
    Map<String, dynamic> packetData, {
    List<NetworkPacket> allPackets = const [],
  }) {
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

    // Server Name Indication
    String? serverName = packetData["tls.handshake.extensions_server_name"].first;
    if (serverName.empty && protocols.contains("tls")) {
      serverName = _lookupSniFromPacketHistory(
        ipSrc: ipSrc,
        ipDst: ipDst,
        portSrc: portSrc,
        portDst: portDst,
        allPackets: allPackets,
      );
    }

    print("${allPackets.length}: $serverName");

    return NetworkPacket(
      ipSrc: ipSrc,
      portSrc: portSrc,
      ipDst: ipDst,
      portDst: portDst,
      protocols: protocols,
      timeInMs: timeInMs,
      size: size,
      serverName: serverName,
    );
  }

  static String? _lookupSniFromPacketHistory({
    required String ipSrc,
    required String ipDst,
    int? portSrc,
    int? portDst,
    List<NetworkPacket> allPackets = const [],
  }) {
    if (portSrc == null || portDst == null) return null;
    for (int i = allPackets.length - 1; i >= 0; i--) {
      NetworkPacket packet = allPackets[i];
      // if packet has no ports, ignore it for sni-lookup
      if (packet.portSrc == null || packet.portDst == null) continue;
      // packet has same ip flow (might be other direction)
      if (packet.ipSrc == ipSrc && packet.ipDst == ipDst ||
          packet.ipSrc == ipDst && packet.ipDst == ipSrc) {
        // packet has same ip flow (might be other direction)
        if (packet.portSrc == portSrc && packet.portDst == portDst ||
            packet.portSrc == portDst && packet.portDst == portSrc) {
          // found previous packet from same flow -> use SNI from there
          return packet.serverName;
        }
      }
    }
    return null;
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
  static String getIpRange(String ip, {int nGroupedOctets = 1}) {
    List<String> parts = ip.split(".");
    assert(parts.length == 4);
    String ipRange = "";
    for (int i = 0; i < parts.length - nGroupedOctets; i++) {
      ipRange += parts[i];
      if (i < parts.length - 1) ipRange += ".";
    }
    for (int i = 0; i < nGroupedOctets; i++) {
      ipRange += "0";
      if (i < nGroupedOctets - 1) ipRange += ".";
    }
    ipRange += "/${32 - nGroupedOctets * 8}";
    return ipRange;
  }

  static int getTrafficLoad(
    Iterable<INetworkConnection> connections, {
    bool inPackets = false,
  }) {
    return connections.fold(
      0,
      (load, con) => load += inPackets ? con.countTotal : con.bytesTotal,
    );
  }

  static List<NetworkConnection> flattenConnections(
      List<INetworkConnection> connections) {
    List<NetworkConnection> allConnections = [];
    for (var con in connections) {
      if (con is ConnectionGroup) {
        allConnections.addAll(con.connections);
      } else if (con is NetworkConnection) {
        allConnections.add(con);
      }
    }
    return allConnections;
  }

  static Map<AnalysisTrafficGroupCubit, int> getTrafficLoadByGroup(
    List<AnalysisTrafficGroupCubit> trafficGroups,
    List<NetworkConnection> connections,
    bool loadInPackets,
  ) {
    Map<AnalysisTrafficGroupCubit, int> loadsByGroup = {};
    for (var group in trafficGroups) {
      loadsByGroup[group] = TrafficAnalyzer.getTrafficLoad(
        getConnectionsWithinGroup(group.group, connections),
        inPackets: loadInPackets,
      );
    }
    return loadsByGroup;
  }

  static Map<String, int> getTrafficLoadByProtocol(
    List<String> protocols,
    List<NetworkConnection> connections,
    bool loadInPackets,
  ) {
    Map<String, int> loadsByProtocol = {};
    for (var protocol in protocols) {
      int protocolLoad = connections.fold(
          0,
          (int load, con) => load += getFilteredPackets(
                  con.packets.where((p) => p.protocols == protocol).toList())
              .map((p) => loadInPackets ? 1 : p.size)
              .nonNulls
              .toList()
              .sum
              .floor());
      loadsByProtocol[protocol] = protocolLoad;
    }
    return loadsByProtocol;
  }

  static List<NetworkConnection> getConnectionsWithinGroup(
    TrafficGroup group,
    List<NetworkConnection> connections,
  ) {
    List<NetworkConnection> groupConnections = [];
    for (var con in group.networkConnections) {
      if (connections.any((c) => c.ip == con.ip)) {
        groupConnections.add(con);
      }
    }
    return groupConnections;
  }
}
