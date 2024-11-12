import 'package:flutter_graph_view/flutter_graph_view.dart';

class TagDecorator extends GraphAlgorithm {
  Map<String, List<GraphAlgorithm>>? taggedDecorators;

  TagDecorator({super.decorators, this.taggedDecorators});

  @override
  void compute(Vertex v, Graph graph) {
    super.compute(v, graph);
    if (taggedDecorators == null || v.tags == null) return;
    for (String tag in v.tags!) {
      if (!taggedDecorators!.containsKey(tag)) continue;
      for (var d in taggedDecorators![tag]!) {
        d.compute(v, graph);
      }
    }
  }

  @override
  void onLoad(Vertex v) {
    super.onLoad(v);
    if (taggedDecorators == null || v.tags == null) return;
    for (String tag in v.tags!) {
      if (!taggedDecorators!.containsKey(tag)) continue;
      for (var d in taggedDecorators![tag]!) {
        d.onLoad(v);
      }
    }
  }
}
