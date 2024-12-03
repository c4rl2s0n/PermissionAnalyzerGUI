import 'package:flutter/material.dart';

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
    List<ContextMenuItem> entries,
  ) =>
      showContextMenu(
        context,
        RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        entries,
      );

  static void showContextMenu(
    BuildContext context,
    RelativeRect position,
    List<ContextMenuItem> entries,
  ) {
    showMenu(
        context: context,
        position: position,
        items: entries
            .map((e) => PopupMenuItem(
                  child: Row(
                    children: [
                      Text(e.name),
                      if (e.icon != null) e.icon!,
                    ],
                  ),
                  onTap: () => e.onTap(context),
                ))
            .toList());
  }
}
