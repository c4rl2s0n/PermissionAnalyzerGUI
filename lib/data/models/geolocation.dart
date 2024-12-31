import 'package:isar/isar.dart';

@embedded
class Geolocation {
  Geolocation({
    required this.ip,
    this.continent,
    this.continentCode,
    this.country,
    this.countryCode,
    this.city,
    this.cityCode,
    this.org,
    this.zip,
    this.lon,
    this.lat,
  });
  Geolocation.fromJson(Map<String, dynamic> jsonMap)
      : this(
          ip: jsonMap['query'] ?? "",
          continent: jsonMap['continent'],
          continentCode: jsonMap['continentCode'],
          country: jsonMap['country'],
          countryCode: jsonMap['countryCode'],
          city: jsonMap['city'],
          cityCode: jsonMap['cityCode'],
          org: jsonMap['org'],
          zip: jsonMap['zip'],
          lat: jsonMap['lat'],
          lon: jsonMap['lon'],
        );
  String ip;
  String? continent;
  String? continentCode;
  String? country;
  String? countryCode;
  String? city;
  String? cityCode;
  String? org;
  String? zip;
  double? lat;
  double? lon;
}
