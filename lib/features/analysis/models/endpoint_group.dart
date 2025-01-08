import 'package:permission_analyzer_gui/data/data.dart';

class EndpointGroup extends INetworkEndpoint{
  EndpointGroup({
    super.hostname,
    this.endpoints = const [],
  });

  @override
  String get id => displayName;
  @override
  String get ipRange{
    // get the common netmask of the grouped endpoints
    List<String> ips = endpoints.map((e) => e.ip).toList();
    if(ips.isEmpty) return "";
    String ipRange = "";
    String refIp = ips.first;
    List<String> ipParts = refIp.split(".");
    int nParts = ipParts.length;
    for(int i=0; i<nParts; i++){
      String part = ipParts[i];
      if(ips.every((ip) => ip.startsWith("$ipRange$part"))){
        ipRange += part;
      }else{
        int nMismatched = nParts - i;
        for(int j=0; j < nMismatched; j++){
          if(j>0) ipRange += ".";
          ipRange += "0";
        }
        ipRange += "/${32-8*nMismatched}";
        break;
      }
      if(i < ipParts.length - 1){
        ipRange += ".";
      }
    }
    return ipRange;
  }
  @override
  String get ip => ipRange;

  @override
  String get displayName => hostname ?? ipRange; // ip range or hostname
  @override
  List<Geolocation> get geolocations => endpoints.map((e) => e.geolocation).nonNulls.toList();
  List<NetworkEndpoint> endpoints;

  @override
  List<String> get tags => endpoints.fold([], (all, e) => [...all, ...e.tags]);
}