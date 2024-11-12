
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/common/common.dart';

typedef LegendBuilder = Widget Function(LegendDecorator)?;
LegendBuilder? legendOverlayBuilder() {
  return (LegendDecorator ld) {
    legendBuilder(
        String tag,
        Function(String) onTap,
        Widget icon,
        List<String> allLegend,
        ) {
      return StatefulBuilder(builder: (context, setState) {
        return InkWell(
          onTap: () {
            onTap(tag);
            setState(() {});
          },
          child: Opacity(
            opacity: allLegend.contains(tag) ? 0.3 : 1,
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  const SizedBox(width: 9),
                  Text(
                    tag,
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }

    var graph = ld.graphComponent?.graph;
    if (graph == null) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...graph.allTags.map((tag) {
          return legendBuilder(
            tag,
            ld.changeTag,
            ColoredBox(
              color: () {
                var i = graph.allTags.indexOf(tag);
                var graphStyle = ld.graphComponent!.options.graphStyle;
                return graphStyle.colorByTag(tag, graph.allTags) ??
                    (i < graphStyle.tagColorByIndex.length
                        ? graphStyle.tagColorByIndex[i]
                        : graphStyle.defaultColor()[0]);
              }(),
              child: const SizedBox(
                width: 30,
                height: 18,
              ),
            ),
            ld.hiddenTags,
          );
        }),
      ],
    );
  };
}
