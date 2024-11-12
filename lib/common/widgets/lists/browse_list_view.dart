import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class BrowseListView<T> extends StatelessWidget {
  const BrowseListView({
    super.key,
    required this.scrollController,
    required this.buildListTile,
    required this.data,
    this.listTileHeight,
    this.autofocusSearchbar = true,
  });

  final ScrollController scrollController;

  final Widget Function(BuildContext context, T entry, List<T>? all)
      buildListTile;
  final double? listTileHeight;
  final bool autofocusSearchbar;
  final List<T> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data to show..."));
    }
    return Scrollbar(
      thickness: context.constants.scrollbarThickness,
      interactive: true,
      controller: scrollController,
      child: SeparatedListView(
        controller: scrollController,
        data: data,
        buildListTile: (context, entry) => buildListTile(context, entry, data),
        listTileHeight: listTileHeight,
      ),
    );
  }
}
