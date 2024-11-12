import 'package:isar/isar.dart';

part 'traffic_endpoint.g.dart';

@embedded
class TrafficEndpoint {
  const TrafficEndpoint({
    this.ip = "",
    this.port,
  });

  final String ip;
  final int? port;
  String get name => "$ip:$port";
}
