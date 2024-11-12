import 'package:isar/isar.dart';

import 'models.dart';

part 'traffic_group.g.dart';

@embedded
class TrafficGroup {
  TrafficGroup({
    this.name = "",
    this.info,
    this.connections = const [],
  });

  String name;
  String? info;
  List<TrafficConnection> connections;
  List<TrafficEndpoint> get endpoints =>
      connections.map((c) => c.endpoint).toList();
}
