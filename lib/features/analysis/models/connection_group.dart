import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'models.dart';

class ConnectionGroup extends INetworkConnection {
  ConnectionGroup({
    required this.endpoint,
    this.connections = const [],
  });

  @override
  EndpointGroup endpoint;
  List<NetworkConnection> connections;

  @override
  List<TestRun> get testRuns => connections.fold([], (all, con) => [...all, ...con.testRuns].distinct);

  @override
  List<String> get ips {
    List<String> allIps = connections
        .fold(<String>[], (all, con) => [...all, ...con.ips]).distinct;
    allIps.sort();
    return allIps;
  }

  @override
  List<int> get ports {
    List<int> allPorts = connections
        .fold(<int>[], (all, con) => [...all, ...con.ports]).distinct;
    allPorts.sort();
    return allPorts;
  }

  @override
  List<String> get protocols {
    List<String> allProtocols = connections.fold(<String>[],
        (List<String> all, con) => [...all, ...con.protocols]).distinct;
    allProtocols.sort();
    return allProtocols;
  }

  @override
  int get inBytes => connections.fold(0, (sum, con) => sum + con.inBytes);

  @override
  int get inCount => connections.fold(0, (sum, con) => sum + con.inCount);

  @override
  int get outBytes => connections.fold(0, (sum, con) => sum + con.outBytes);

  @override
  int get outCount => connections.fold(0, (sum, con) => sum + con.outCount);

  @override
  List<NetworkPacket> get packets =>
      connections.fold([], (all, con) => [...all, ...con.packets]);


  @override
  ConnectionGroup get copy => this;
}
