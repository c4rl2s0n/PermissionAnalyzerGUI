import 'dart:math';

import 'package:flutter_graph_view/flutter_graph_view.dart';

class RepellingCenterDecorator extends GraphAlgorithm {
  RepellingCenterDecorator({double k = 50})
      : super(decorators: [CoulombCenterDecorator(k: k), ForceDecorator()]);

  @override
  void onGraphLoad(Graph graph) {
    var v = graph.vertexes.where((v) => v.tags?.contains("center") ?? false).firstOrNull;
    var radius = max(center.dy, 100) * .8;
    v?.position = Vector2(center.dx + radius * 0.5, center.dy + radius*0.5);
  }

}
