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

  static List<INetworkEndpoint>
      getEndpointsFromIConnections<T extends INetworkConnection>(
          List<T> connections) {
    return T == NetworkConnection
        ? getEndpointsFromConnections(connections as List<NetworkConnection>)
        : T == ConnectionGroup
            ? getEndpointsFromConnectionGroups(
                connections as List<ConnectionGroup>)
            : [];
  }

  static List<NetworkEndpoint> getEndpointsFromConnections(
    List<NetworkConnection> connections, {
    bool filtered = true,
    INetworkEndpointRepository? endpointRepository,
  }) {
    connections =
        (filtered ? getFilteredConnections(connections) : connections).toList();
    if (endpointRepository != null) {
      List<String> ips = connections.map((c) => c.ip).toList().distinct;
      Map<String, NetworkEndpoint> endpointMap = {};
      List<NetworkEndpoint> endpoints = endpointRepository.getAllByIp(ips);
      for (var ep in endpoints) {
        endpointMap[ep.ip] = ep;
      }
      List<NetworkEndpoint> updatedEndpoints = [];
      for (var connection in connections) {
        NetworkEndpoint endpoint = endpointMap[connection.ip]!;
        connection.endpoint = endpoint;

        // add server names to endpoint, in case they are missing
        if (connection.serverName.notEmpty &&
            !endpoint.serverNames.contains(connection.serverName!)) {
          endpoint.serverNames = [
            ...endpoint.serverNames,
            connection.serverName!
          ];
          endpoint.serverNames.sort();
          updatedEndpoints.add(endpoint);
        }
      }
      // update endpoints, if a serverName was added
      if (updatedEndpoints.isNotEmpty) {
        endpointRepository.updateAll(updatedEndpoints);
      }
      return endpoints;
    }
    return connections.map((c) => c.endpoint).toList().distinct;
  }

  static List<EndpointGroup> getEndpointsFromConnectionGroups(
    List<ConnectionGroup> connections, {
    bool filtered = true,
  }) {
    connections =
        (filtered ? getFilteredConnections(connections) : connections).toList();
    return getGroupedConnections(connections)
        .map((c) => c.endpoint)
        .toList()
        .distinct;
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
    return getConnectionsFromTestRuns(
      tests,
      filtered: filtered,
      grouped: grouped,
    );
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

  static bool _shouldFilterIp(String ip) => _isLocalIp(ip);

  static bool _isLocalIp(String ip) =>
      // TODO: define in settings maybe? might be different, depending on device
      ip.startsWith("10.0.") || ip.startsWith("192.168.") || ip == "127.0.0.1";

  static List<INetworkConnection> groupIConnectionsByEndpoint(
      List<INetworkConnection> connections) {
    return connections is List<NetworkConnection>
        ? groupConnectionsByEndpoint(connections)
        : connections is List<ConnectionGroup>
            ? groupConnectionGroupsByEndpoint(connections)
            : [];
  }

  static List<NetworkConnection> groupConnectionsByEndpoint(
    List<NetworkConnection> connections,
  ) {
    Map<String, NetworkConnection> grouped = {};
    for (var con in connections) {
      String key = con.endpoint.id;
      if (!grouped.keys.contains(key)) {
        grouped[key] = con.copy;
      } else {
        NetworkConnection c = grouped[key]!;
        c.packets = [...c.packets, ...con.packets];
      }
    }
    List<NetworkConnection> nCons = grouped.values.toList();
    for (var c in nCons) {
      c.analyzePackets();
    }
    return nCons;
  }

  static List<ConnectionGroup> groupConnectionGroupsByEndpoint(
    List<ConnectionGroup> connections,
  ) {
    Map<EndpointGroup, ConnectionGroup> grouped = {};
    for (var con in connections) {
      if (!grouped.keys.contains(con.endpoint)) {
        grouped[con.endpoint] = con.copy;
      } else {
        ConnectionGroup c = grouped[con.endpoint]!;
        c.connections = [...c.connections, ...con.connections];
      }
    }
    return grouped.values.toList();
  }

  static List<ConnectionGroup> getGroupedConnections(
    List<INetworkConnection> connections, {
    int nGroupedOctets = 1, // number of octets to group over
  }) {
    // different SNIs at same IP might result in the same group
    Map<String, ConnectionGroup> connectionGroups = {};
    void addEndpoint(ConnectionGroup group, NetworkEndpoint endpoint) {
      if (!group.endpoint.endpoints.any((e) => e.id == endpoint.id)) {
        group.endpoint.endpoints.add(endpoint);
      }
    }

    bool testForKey(String? key, NetworkConnection connection,
        {EndpointGroup Function(NetworkEndpoint, String)?
            getInitialEndpointGroup}) {
      if (key.notEmpty) {
        // create the ConnectionGroup if not yet exists
        if (!connectionGroups.containsKey(key!)) {
          connectionGroups[key] = ConnectionGroup(
            endpoint: getInitialEndpointGroup?.call(connection.endpoint, key) ??
                EndpointGroup(endpoints: [connection.endpoint]),
            connections: [connection],
          );
        } else {
          // add connection to existing ConnectionGroup
          addEndpoint(connectionGroups[key]!, connection.endpoint);
          connectionGroups[key]!.connections.add(connection);
        }
        return true;
      }
      return false;
    }

    for (var connection in connections) {
      if (connection is ConnectionGroup) {
        // connection is already grouped
        connectionGroups[connection.endpoint.displayName] = connection;
        continue;
      }
      connection as NetworkConnection;

      // group by server name (SNI)
      String? sni = connection.serverName;
      if (testForKey(
        sni,
        connection,
        getInitialEndpointGroup: (ep, sni) =>
            SniEndpoint(endpoints: [ep], serverName: sni),
      )) continue;

      // group by domain name
      String? domain = connection.endpoint.domainString;
      if (testForKey(domain, connection)) continue;

      // group by ipRange
      String ipRange = getIpRange(
        connection.endpoint.ip,
        nGroupedOctets: nGroupedOctets,
      );
      testForKey(ipRange, connection);
    }

    return connectionGroups.values.toList();
  }

  static List<NetworkConnection> getConnectionsFromPackets(
    List<NetworkPacket> packets, {
    TestRun? testRun,
    bool filtered = true,
    INetworkEndpointRepository? endpointRepository,
  }) {
    List<String> ips = [
      ...packets.map((p) => p.ipSrc),
      ...packets.map((p) => p.ipSrc)
    ].distinct;
    List<NetworkEndpoint>? endpoints = endpointRepository?.getAllByIp(ips);
    Map<String, NetworkConnection> connections = {};
    for (var packet in packets) {
      String key;
      if (_isLocalIp(packet.src)) {
        // outgoing connection
        key = "${packet.ipDst}:${packet.serverName}";
        if (!connections.containsKey(key)) {
          connections[key] = NetworkConnection(
            ip: packet.ipDst,
            endpoint: endpoints
                ?.where((e) => e.ip == packet.ipDst)
                .firstOrNull, //endpointRepository?.getByIp(packet.ipDst),
            port: packet.portDst,
            packets: [],
            testRuns: testRun != null ? [testRun] : [],
            serverName: packet.serverName,
          );
        }
      } else if (_isLocalIp(packet.dst)) {
        // incoming connection
        key = "${packet.ipSrc}:${packet.serverName}";
        if (!connections.containsKey(key)) {
          connections[key] = NetworkConnection(
            ip: packet.ipSrc,
            endpoint: endpoints
                ?.where((e) => e.ip == packet.ipSrc)
                .firstOrNull, //endpointRepository?.getByIp(packet.ipSrc),
            port: packet.portSrc,
            packets: [],
            testRuns: testRun != null ? [testRun] : [],
            serverName: packet.serverName,
          );
        }
      } else {
        // ignore packets that are not local on any side
        continue;
      }

      // add packet to connection
      NetworkConnection con = connections[key]!;
      con.packets.add(packet);
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
    String? serverName = packetData["tls.handshake.extensions_server_name"]?.first;
    if (serverName.empty && protocols.contains("tls")) {
      serverName = _lookupSniFromPacketHistory(
        ipSrc: ipSrc,
        ipDst: ipDst,
        portSrc: portSrc,
        portDst: portDst,
        allPackets: allPackets,
      );
    }

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

      // if packet has no SNI or ports, ignore it for sni-lookup
      if (packet.serverName.empty ||
          packet.portSrc == null ||
          packet.portDst == null) continue;
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
      if (connections.any((c) => c.ip == con.ip && c.serverName == con.serverName)) {
        groupConnections.add(con);
      }
    }
    return groupConnections;
  }
}
