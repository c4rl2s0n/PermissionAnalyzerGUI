import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class EndpointGroup extends INetworkEndpoint {
  EndpointGroup({
    this.endpoints = const [],
  });

  @override
  String get id => name;

  String get ipRange {
    // get the common netmask of the grouped endpoints
    List<String> ips = endpoints.map((e) => e.ip).toList();
    if (ips.isEmpty) return "";
    String ipRange = "";
    String refIp = ips.first;
    List<String> ipParts = refIp.split(".");
    int nParts = ipParts.length;
    for (int i = 0; i < nParts; i++) {
      String part = ipParts[i];
      if (ips.every((ip) => ip.startsWith("$ipRange$part"))) {
        ipRange += part;
      } else {
        int nMismatched = nParts - i;
        for (int j = 0; j < nMismatched; j++) {
          if (j > 0) ipRange += ".";
          ipRange += "0";
        }
        ipRange += "/${32 - 8 * nMismatched}";
        break;
      }
      if (i < ipParts.length - 1) {
        ipRange += ".";
      }
    }
    return ipRange;
  }

  @override
  String get ip => ipRange;

  @override
  String get name => domainString ?? ip;

  @override
  List<Geolocation> get geolocations =>
      endpoints.map((e) => e.geolocation).nonNulls.toList();
  List<NetworkEndpoint> endpoints;

  String? get hostnameString =>
      hostnames.isEmpty ? null : hostnames.distinct.sorted.join("\n");
  @override
  List<String> get hostnames => endpoints
      .fold(<String>[], (all, e) => [...all, ...e.hostnames])
      .distinct
      .sorted;
  @override
  List<String> get serverNames => endpoints
      .fold(<String>[], (all, e) => [...all, ...e.serverNames])
      .distinct
      .sorted;

  @override
  String? get domainString => domains?.join("\n");
  List<String>? _domains;
  List<String>? get domains {
    if (!hasHostname) return null;
    if (_domains == null) {
      _loadDomains();
    }
    return _domains;
  }

  void _loadDomains() {
    _domains = null;
    List<String> hostnames = this.hostnames;
    if (hostnames.isEmpty) return;
    _domains = [];
    for (var hostname in hostnames) {
      List<String> parts = hostname.split(".");
      if (parts.length <= 2) continue;
      List<String> rev = parts.reversed.toList();
      String domain = "${rev[1]}.${rev[0]}";
      if (!_domains!.contains(domain)) _domains!.add(domain);
    }
    _domains!.sort();
  }

  @override
  List<String> get tags => endpoints.fold([], (all, e) => [...all, ...e.tags]);
}

class SniEndpoint extends EndpointGroup {
  SniEndpoint({
    super.endpoints,
    required this.serverName,
  });

  String serverName;

  @override
  String get id => name;

  @override
  String get ip => ipRange;

  @override
  String get name => serverName;

  @override
  List<String> get serverNames => [serverName];
}
