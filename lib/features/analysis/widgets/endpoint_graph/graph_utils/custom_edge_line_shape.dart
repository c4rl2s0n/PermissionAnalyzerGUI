import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/graph_utils/utils.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/models/models.dart';

class CustomEdgeLineShape extends EdgeLineShape {
  @override
  void setPaint(Edge edge) {
    GraphEdge data = edge.data as GraphEdge;
    var paint = edge.cpn!.paint;
    paint.strokeWidth = _getStrokeWidth(edge);
    paint.strokeWidth /= edge.cpn!.game.camera.viewfinder.zoom;
    paint.style = PaintingStyle.stroke;
    var startPoint = Offset.zero;
    var endPoint = Offset(EdgeShape.len(edge), paint.strokeWidth);
    var hoverOpacity = edge.cpn?.gameRef.options.graphStyle.hoverOpacity ?? .5;
    List<ui.Color> colors = [
      edge.start.colors.last,
      if (data.common) Colors.cyan,
      if (data.hasSNI) Colors.orange,
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

  double _getStrokeWidth(Edge edge){
    GraphEdge data = edge.data as GraphEdge;
    double hoverStrokeWidth = minEdgeWidth + data.size * maxEdgeWidth;
    if(edge.isHovered) hoverStrokeWidth *= 1.2;
    return hoverStrokeWidth;
  }
  
  @override
  bool? hoverTest(Vector2 point, Edge edge, EdgeComponent edgeComponent) {
    var offset = Offset(point.x, point.y);

    double hoverStrokeWidth = _getStrokeWidth(edge);
    
    if (edge.isLoop) {
      return edge.path!.contains(offset) &&
          !loopPath(edge, hoverStrokeWidth).contains(offset);
    } else {
      if (edge.computeIndex == 0) {
        return null;
      }
      Path? minusArea = edge.path?.shift(Offset(
        0,
        edge.computeIndex > 0 ? -hoverStrokeWidth : hoverStrokeWidth,
      ));
      return ((edge.path?.contains(offset) ?? false) &&
          (!(minusArea?.contains(offset) ?? true)));
    }
  }
}
