import 'dart:ui';

import 'package:permission_analyzer_gui/data/data.dart';

class ConnectionTimeline {
  ConnectionTimeline({
    String fallbackName = "Unknown",
    this.color,
    required this.test,
    required this.timeline,
  }){
    NetworkConnection? con = timeline.nonNulls.whereType<NetworkConnection>().firstOrNull;
    name = con?.serverName ?? con?.endpoint.name ?? fallbackName;
  }
  late String name;
  Color? color;
  TestRun test;
  List<INetworkConnection?> timeline;
}
