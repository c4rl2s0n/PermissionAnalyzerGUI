import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/graph_utils/utils.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/models/models.dart';

class EndpointAnalysisConverter extends DataConvertor<GraphVertex, GraphEdge> {
  @override
  Edge convertEdge(GraphEdge e, Graph graph) {
    Edge result = Edge();
    result.ranking = e.dst.countTotal;
    result.edgeName = "${e.src.name}_${e.dst.endpoint.id}";

    result.start = graph.keyCache[e.src.name]!;
    result.end = graph.keyCache[e.dst.endpoint.id]!;

    return result;
  }

  @override
  Graph convertGraph(data, {Graph? graph}) {
    var result = graph ?? Graph();
    result.data = data;

    if (data is GraphData) {
      var edgeDataList = data.edges;
      var vertexDataList = data.vertexes;
      for (var v in vertexDataList) {
        addVertex(v, result);
      }
      for (var e in edgeDataList) {
        addEdge(e, result);
      }
    }
    return result;
  }

  @override
  Vertex convertVertex(GraphVertex v, Graph graph) {
    Vertex vertex = Vertex()
      ..id = v.id
      ..tags = v.tags
      ..radius = v.size * (maxVertexSize-minVertexSize) + minVertexSize
      ..tag = v.tags.firstOrNull ?? "vertex";
    return vertex;
  }
}
