import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/features/analysis/colors.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/graph_utils/utils.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/models/models.dart';

class CustomEdgeLineShape extends EdgeLineShape {
  Color _colorByVertex(Vertex v){
    List<String>? tags = v.tags;
    if(tags == null || tags.isEmpty) return v.colors.last;
    if(tags.contains(tGroup)){
      return v.colors.first;
    }else if(tags.contains(tEndpoint)){
      if(tags.contains(tSniEndpoint)){
        return graphTagColors[tSniEndpoint]!;
      }
      if(tags.contains(tUnique)){
        return graphTagColors[tUnique]!;
      }
      if(tags.contains(tCommon)){
        return graphTagColors[tCommon]!;
      }
    }
    return v.colors.last;
  }

  @override
  void setPaint(Edge edge) {
    GraphEdge data = edge.data as GraphEdge;
    var paint = edge.cpn!.paint;
    paint.strokeWidth = _getStrokeWidth(edge);
    paint.strokeWidth /= edge.cpn!.game.camera.viewfinder.zoom;
    paint.style = PaintingStyle.stroke;
    var startPoint = Offset.zero;
    var endPoint = Offset(EdgeShape.len(edge), paint.strokeWidth);
    var hoverOpacity = edge.cpn?.gameRef.options.graphStyle.hoverOpacity ?? .3;
    var idleOpacity = .6;
    List<ui.Color> colors = [
      _colorByVertex(edge.start),
      if (data.common) Colors.green,
      if (data.hasSNI) graphTagColors[tSniEndpoint]!,
      if(edge.end != null) _colorByVertex(edge.end!),
    ];
    List<double> colorStops = List.generate(colors.length, (i) => i / (colors.length-1));
    var graph = edge.cpn!.gameRef.graph;
    if (isWeaken(edge)) {
      paint.shader = ui.Gradient.linear(
        startPoint,
        endPoint,
        colors.map((c) => c.withOpacity(hoverOpacity)).toList(),
        colorStops,
      );
    } else if(graph.hoverVertex == null && graph.hoverEdge == null){
      paint.shader = ui.Gradient.linear(
        startPoint,
        endPoint,
        colors.map((c) => c.withOpacity(idleOpacity)).toList(),
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
