import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/helper.dart';

import 'models.dart';

part 'network_endpoint.g.dart';

abstract class INetworkEndpoint{
  INetworkEndpoint({this.hostname});
  String get ipRange;
  String get ip;
  String? hostname;
  List<Geolocation> get geolocations;
  bool get hasHostname => hostname != null && hostname!.isNotEmpty;
  String get id;

  List<String> get tags;

  String get name => hostname ?? ip;
  String get displayName => domain ?? hostname ?? ip;

  String? get domain {
    if (hostname == null) return null;
    List<String> parts = hostname!.split(".");
    if (parts.length <= 2) return hostname;
    List<String> rev = parts.reversed.toList();
    return "${rev[1]}.${rev[0]}";
  }
  
  int compareTo(NetworkEndpoint other) => hostname != null && other.hostname != null ? compareHostnames(hostname!, other.hostname!) : (hostname ?? ip).compareTo(other.hostname ?? other.ip);
}

@Collection(ignore: {'name', 'displayName'})
class NetworkEndpoint extends INetworkEndpoint{
  NetworkEndpoint({
    this.ip = "",
    this.analyzed = false,
    this.geolocation,
    this.whois,
    this.tags = const [],
    super.hostname,
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

  String? whois;

  @override
  List<Geolocation> get geolocations => geolocation != null ? [geolocation!] : [];
  Geolocation? geolocation;

  @override
  List<String> tags;
}
