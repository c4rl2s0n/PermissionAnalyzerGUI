import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';

class GraphEdge {
  GraphEdge({
    required this.src,
    required this.dst,
    this.common = false,
    this.size = 0,
  });

  TrafficGroup src;
  INetworkConnection dst;
  bool common;
  double size;
}
