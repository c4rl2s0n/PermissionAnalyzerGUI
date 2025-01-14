import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/helper.dart';

import 'models.dart';

part 'network_endpoint.g.dart';

abstract class INetworkEndpoint{
  INetworkEndpoint();
  String get ip;
  String get id;
  List<String> get serverNames;
  bool get hasServerName => serverNames.isNotEmpty;
  List<String> get hostnames;
  bool get hasHostname => hostnames.isNotEmpty;

  List<Geolocation> get geolocations;
  List<String> get tags;

  String get name;
  String get displayName => name;
  String? get domainString;



  String? domainFromHostname(String? hostname){
    if(hostname.empty) return null;
    List<String> parts = hostname!.split(".");
    if (parts.length <= 2) return null;
    List<String> rev = parts.reversed.toList();
    String domain = "${rev[1]}.${rev[0]}";
    return domain;
  }
}

@Collection(ignore: {'name', 'displayName', 'serverName', 'domains'})
class NetworkEndpoint extends INetworkEndpoint{
  NetworkEndpoint({
    this.ip = "",
    this.analyzed = false,
    this.geolocation,
    this.whois,
    this.tags = const [],
    this.serverNames = const [],
    this.hostname,
  });

  Id isarId = Isar.autoIncrement;
  @override
  String get id => ip;
  @override
  @Index(unique: true, replace: false)
  String ip;
  bool analyzed;

  String? whois;

  String? hostname;
  @override
  List<String> get hostnames => hostname.empty ? [] : [hostname!];
  @override
  List<String> serverNames;

  @override
  List<Geolocation> get geolocations => geolocation != null ? [geolocation!] : [];
  Geolocation? geolocation;

  @override
  List<String> tags;


  @override
  String get name => hostname ?? ip;
  @override
  String get displayName => domainString ?? hostname ?? ip;
  @override
  String? get domainString => domainFromHostname(hostname);


  int compareTo(NetworkEndpoint other) => hostname != null && other.hostname != null ? compareHostnames(hostname!, other.hostname!) : (hostname ?? ip).compareTo(other.hostname ?? other.ip);
}
