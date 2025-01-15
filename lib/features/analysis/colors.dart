import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/keys.dart';

const Map<String, Color> graphTagColors = <String, Color>{
  // Traffic Groups
  tGroup: Colors.transparent,// Color(0xffcaf0f8),
  tApplication: Color(0xff070ab9),
  tScenario: Color(0xff0077b6),
  tConstellation: Color(0xFF00b4d8),
  tTest: Color(0xff90e0ef),
  // Endpoints
  //tEndpoint: Color(0xffc4e1b9),
  tIpOnly: Color(0xffa015d7),
  tHostname: Color(0xFF117934),
  tServerName: Color(0xffa3ff07),
  tSniEndpoint: Color(0xFFFA8B11),
  tUnique: Color(0xFFc1121f),
  tCommon: Color(0xFF8338ec),
};
const Map<String, Color> onGraphTagColors = <String, Color>{
  // Traffic Groups
  tGroup: Colors.black,
  tApplication: Color(0xe6ffffff),
  tScenario: Colors.black,
  tConstellation: Colors.black,
  tTest: Colors.black,
  // Endpoints
  tEndpoint: Colors.black,
  tIpOnly: Colors.white,
  tHostname: Colors.white,
  tServerName: Colors.black,
  tSniEndpoint: Colors.white,
  tUnique: Colors.white,
  tCommon: Colors.black,
};

const List<Color> trafficGroupColors = [
  Color(0xff0c2aa2),
  Color(0xffbb6207),
  Color(0xFF264653),
  Color(0xFFe9c46a),
  Color(0xFF2a9d8f),
  Color(0xFFa5be00),
  Color(0xFFe76f51),
  Color(0xFF8338ec),
  Color(0xFF81b29a),
  Color(0xFF9e2a2b),
];