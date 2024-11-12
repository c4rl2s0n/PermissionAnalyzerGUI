import 'package:isar/isar.dart';

import 'models.dart';

part 'endpoint_analysis.g.dart';

@embedded
class EndpointAnalysis {
  EndpointAnalysis({
    this.trafficGroups = const [],
    this.endpoints = const [],
  }) {
    if (endpoints.isEmpty) {
      endpoints = _endpoints;
    }
  }

  List<TrafficGroup> trafficGroups;
  List<TrafficEndpoint> endpoints;

  @ignore
  List<TrafficConnection> get connections{
    List<TrafficConnection> connections = [];
    for(var group in trafficGroups){
      connections.addAll(group.connections);
    }
    return connections;
  }

  @ignore
  List<TrafficEndpoint> get _endpoints {
    List<TrafficEndpoint> endpoints = [];
    for (var group in trafficGroups) {
      // get all connections
      endpoints.addAll(
        group.connections
            .where(
              (c) =>
                  !c.endpoint.ip.startsWith("10.0.") &&
                  !c.endpoint.ip.startsWith("127.0.0.1") &&
                  !endpoints.any((e) => e.name == c.endpoint.name),
            )
            .map((c) => c.endpoint),
      );
    }
    return endpoints;
  }
}
