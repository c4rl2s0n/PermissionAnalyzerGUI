import 'dart:ui';

import 'package:permission_analyzer_gui/data/data.dart';

class ConnectionTimeline {
  ConnectionTimeline({
    required this.name,
    this.color,
    required this.test,
    required this.timeline,
  });
  String name;
  Color? color;
  TestRun test;
  List<INetworkConnection?> timeline;
}
