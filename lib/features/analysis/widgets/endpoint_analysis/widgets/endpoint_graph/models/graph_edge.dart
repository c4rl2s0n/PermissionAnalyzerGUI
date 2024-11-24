import 'package:permission_analyzer_gui/data/data.dart';

class GraphEdge {
  GraphEdge({
    required this.src,
    required this.dst,
    this.common = false,
  });

  TrafficGroup src;
  TrafficConnection dst;
  bool common;
}
