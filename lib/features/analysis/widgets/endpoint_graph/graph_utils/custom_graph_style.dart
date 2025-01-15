import 'dart:ui';

import 'package:flutter_graph_view/flutter_graph_view.dart';

class CustomGraphStyle extends GraphStyle{
  @override
  Color? colorByTag(String tag, List<String> allTags) {
    Color? color;
    if (tagColor != null) {
      color = tagColor![tag];
    }
    return color;
  }
}