
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class EndpointAnalyzer{
  static Future<String?> lookupHostname(String ip)async{
    try {
      InternetAddress domain = await InternetAddress(ip).reverse();
      if (domain.host.isEmpty) return null;
      return domain.host;
    }catch(_){
      return null;
    }
  }
  static Future<String?> lookupWhois(String ip)async{
    try {
      return (await SystemProcess().run("whois", [ip])).outText;
    }catch(_){
      return null;
    }
  }
  static Future<Map<String, Geolocation>> lookupGeolocations(List<String> ips)async{
    int blockSize = 100; // can check up to 100 ips at once
    Map<String, Geolocation> geolocations = {};
    for(int i=0; i<ips.length;i+=blockSize){
      List<String> ipBlock = ips.sublist(i, min(i+blockSize, ips.length));
      List<Map<String, String>> requestBody = ipBlock.map((ip) => <String, String>{
        "query": ip,
        "fields": "query,continent,continentCode,country,countryCode,city,cityCode,org,zip,lat,lon",
        // "lang": "response language optional"
      }).toList();
      Response result = await post(
        Uri.parse('http://ip-api.com/batch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      List<dynamic> responseData = jsonDecode(result.body);
      List<Geolocation> locations = responseData.map((d) => Geolocation.fromJson(d)).toList();
      for(var location in locations){
        geolocations[location.ip] = location;
      }
    }
    return geolocations;
  }
}