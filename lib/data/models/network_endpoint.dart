import 'package:isar/isar.dart';

part 'network_endpoint.g.dart';

@collection
class NetworkEndpoint{
  NetworkEndpoint({
    this.ip = "",
    this.hostname,
  });
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: false)
  String ip;
  String? hostname;
}
