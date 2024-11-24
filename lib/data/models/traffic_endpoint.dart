import 'package:isar/isar.dart';

part 'traffic_endpoint.g.dart';

@embedded
class TrafficEndpoint {
  TrafficEndpoint({
    this.ip = "",
    this.port,
    this.notes,
    this.hostname,
  });

  final String ip;
  final int? port;
  String? notes;
  String? hostname;
  String get name => "${hostname??ip}${port != null ? ":$port" : ""}";
}
