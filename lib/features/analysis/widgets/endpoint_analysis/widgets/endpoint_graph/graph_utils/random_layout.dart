import 'dart:math';

import 'package:flutter_graph_view/flutter_graph_view.dart';

class RandomLayout extends GraphAlgorithm {

  RandomLayout({super.decorators});

  @override
  void onGraphLoad(Graph graph) {
    var vertexes = graph.vertexes;
    for (var i = 0; i < vertexes.length; i++) {
      var v = vertexes[i];
      if (v.position == Vector2(0, 0)) {
        var size = v.cpn!.gameRef.camera.visibleWorldRect;
        //v.radius = 5;
        v.position = Vector2(Random().nextDouble() * (size.width - 50) + 25,
            Random().nextDouble() * (size.height - 50) + 25);
      }
    }
  }
  @override
  void compute(Vertex v, Graph graph) {
    super.compute(v, graph);
    if (v.position == Vector2(0, 0)) {
      var size = v.cpn!.gameRef.camera.visibleWorldRect;
      v.position = Vector2(Random().nextDouble() * (size.width - 50) + 25,
          Random().nextDouble() * (size.height - 50) + 25);
    }
  }

  @override
  void onDrag(Vertex hoverVertex, Vector2 globalDelta, Viewfinder viewfinder) {
    var zoom = viewfinder.zoom;
    hoverVertex.position += globalDelta / zoom;
    hoverVertex.cpn?.algorithmCompute(this);
  }
}
