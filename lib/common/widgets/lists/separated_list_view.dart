import 'package:flutter_template/common/common.dart';
import 'package:flutter/material.dart';

class SeparatedListView<T> extends StatelessWidget {
  const SeparatedListView({
    required this.data,
    this.listTileHeight,
    required this.buildListTile,
    this.controller,
    this.primary,
    super.key,
  }) : assert(controller == null || primary == null || primary == false);

  final List<T> data;
  final double? listTileHeight;
  final Widget Function(BuildContext, T) buildListTile;
  final ScrollController? controller;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      primary: controller != null ? false : primary,
      itemExtent: listTileHeight != null ? listTileHeight! + context.constants.dividerHeight : null,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: context.constants.dividerHeight,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: index == 0 ? Colors.transparent : context.colors.divider,
            ),
            buildListTile(context, data[index]),
          ],
        );
      },
    );
  }
}
