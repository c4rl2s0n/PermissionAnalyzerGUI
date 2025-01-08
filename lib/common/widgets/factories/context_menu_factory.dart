import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class ContextMenuItem {
  ContextMenuItem({
    required this.name,
    required this.onTap,
    this.value,
    this.icon,
  });
  dynamic value;
  String name;
  Icon? icon;
  void Function(BuildContext) onTap;
}

class ContextMenuFactory {
  static void showContextMenuOnTap(
    BuildContext context,
    TapDownDetails details,
    List<ContextMenuItem> entries, {
    double? maxWidth,
  }) =>
      showContextMenu(
        context,
        RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        entries,
        maxWidth: maxWidth,
      );

  static void showContextMenuOnPosition(
    BuildContext context,
    Offset position,
    List<ContextMenuItem> entries, {
    double? maxWidth,
  }) =>
      showContextMenu(
        context,
        RelativeRect.fromLTRB(
          position.dx,
          position.dy,
          position.dx,
          position.dy,
        ),
        entries,
        maxWidth: maxWidth,
      );

  static void showContextMenu(
    BuildContext context,
    RelativeRect position,
    List<ContextMenuItem> entries, {
    double? maxWidth,
  }) {
    showMenu(
        context: context,
        position: position,
        constraints: BoxConstraints(maxWidth: maxWidth ?? 666),
        items: entries
            .map((e) => PopupMenuItem(
                  child: Row(
                    children: [
                      if (e.icon != null) ...[
                        IconTheme(
                          data: context.iconTheme.copyWith(
                              color:
                                  e.icon!.color ?? context.colors.onSecondary),
                          child: e.icon!,
                        ),
                        Margin.horizontal(context.constants.smallSpacing),
                      ],
                      Text(e.name),
                    ],
                  ),
                  onTap: () => e.onTap(context),
                ))
            .toList());
  }
}
