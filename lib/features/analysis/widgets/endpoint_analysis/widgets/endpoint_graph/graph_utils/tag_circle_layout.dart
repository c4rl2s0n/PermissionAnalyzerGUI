import 'dart:math';

import 'package:flutter_graph_view/flutter_graph_view.dart';

class TagCircleLayout extends GraphAlgorithm {
  String tag;

  TagCircleLayout({super.decorators, required this.tag});

  @override
  void onGraphLoad(Graph graph) {
    var radius = max(center.dy, 100) * .9;
    var vertexes = graph.vertexes.where((v) => v.tags?.contains(tag) ?? false).toList();
    for (var i = 0; i < vertexes.length; i++) {
      var vertex = vertexes[i];
      var angle = 2 * pi * i / vertexes.length;
      var x = sin(angle) * radius;
      var y = -cos(angle) * radius;

      vertex.position = Vector2(x + center.dx, y + center.dy);
    }
  }

  @override
  void onDrag(Vertex hoverVertex, Vector2 globalDelta, Viewfinder viewfinder) {
    var zoom = viewfinder.zoom;
    hoverVertex.position += globalDelta / zoom;
  }
}
