import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/widgets/endpoint_graph/models/models.dart';

class CustomEdgeLineShape extends EdgeLineShape {
  @override
  void setPaint(Edge edge) {
    GraphEdge data = edge.data as GraphEdge;
    var paint = edge.cpn!.paint;
    paint.strokeWidth = edge.isHovered
        ? 4
        : data.common
            ? 2.5
            : 1.5;
    paint.strokeWidth /= edge.cpn!.game.camera.viewfinder.zoom;
    paint.style = PaintingStyle.stroke;
    var startPoint = Offset.zero;
    var endPoint = Offset(EdgeShape.len(edge), paint.strokeWidth);
    var hoverOpacity = edge.cpn?.gameRef.options.graphStyle.hoverOpacity ?? .5;
    List<ui.Color> colors = [
      edge.start.colors.last,
      if (data.common) Colors.cyan,
      (edge.end?.colors.last ?? Colors.white)
    ];
    List<double> colorStops = List.generate(colors.length, (i) => i / (colors.length-1));
    if (isWeaken(edge)) {
      paint.shader = ui.Gradient.linear(
        startPoint,
        endPoint,
        colors.map((c) => c.withOpacity(hoverOpacity)).toList(),
        colorStops,
      );
    } else {
      paint.shader = ui.Gradient.linear(
        startPoint,
        endPoint,
        colors,
        colorStops,
      );
    }
  }
}
