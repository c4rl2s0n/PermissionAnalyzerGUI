import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/keys.dart';

const Map<String, Color> graphTagColors = <String, Color>{
  tConstellation: Color(0xE5E1540A),
  tTest: Color(0xE5B20AE1),
  tScenario: Color(0xE5FFBC13),
  tApplication: Color(0xE597D718),
  tGroup: Colors.blue,
  tEndpoint: Color(0xE5E16110), //Colors.indigo,
  tIpOnly: Color(0xFFBC13FF), //Colors.redAccent,
  tHostname: Color(0xFF13FFD9), //Colors.redAccent,
  tServerName: Color(0xFFA8FF1A), //Colors.greenAccent,
  tUnique: Colors.yellow,
  tCommon: Colors.greenAccent,
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