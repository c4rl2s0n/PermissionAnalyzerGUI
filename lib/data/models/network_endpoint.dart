import 'package:isar/isar.dart';

import 'models.dart';

part 'network_endpoint.g.dart';

abstract class INetworkEndpoint{
  INetworkEndpoint({this.hostname, this.geolocation});
  String get ipRange;
  String get ip;
  String? hostname;
  Geolocation? geolocation;
  bool get hasHostname => hostname != null && hostname!.isNotEmpty;
  String get id;

  String get name => domain ?? hostname ?? ip;

  String? get domain {
    if (hostname == null) return null;
    List<String> parts = hostname!.split(".");
    if (parts.length <= 2) return hostname;
    List<String> rev = parts.reversed.toList();
    return "${rev[1]}.${rev[0]}";
  }
}

@Collection(ignore: {'name'})
class NetworkEndpoint extends INetworkEndpoint{
  NetworkEndpoint({
    this.ip = "",
    this.analyzed = false,
    super.hostname,
    super.geolocation,
  });

  Id isarId = Isar.autoIncrement;
  @override
  String get id => ip;
  @override
  @Index(unique: true, replace: false)
  String ip;
  @override
  String get ipRange => ip;
  bool analyzed;
}
