import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class PageComponentFactory {
  static Widget scaffold(
    BuildContext context, {
    required AppBar appBar,
    required Widget body,
    bool withPadding = true,
  }) {
    return SelectionArea(
      // hide contextMenu
      contextMenuBuilder: (_,__) => const SizedBox.shrink(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: appBar,
        body: Padding(
            padding: withPadding
                ? EdgeInsets.all(context.constants.spacing)
                : EdgeInsets.zero,
            child: body,
          
        ),
      ),
    );
  }

  static AppBar appBar(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
  }) {
    ColorAccessor colors = context.colors;
    IconThemeData iconTheme =
        context.themeData.iconTheme.copyWith(color: context.colors.onPrimary);
    return AppBar(
      toolbarHeight: 45,
      titleTextStyle:
          context.textTheme.headlineLarge?.copyWith(color: colors.onPrimary),
      title: Text(title),
      actionsIconTheme: iconTheme,
      actions: actions,
      iconTheme: iconTheme.copyWith(size: 20),
      backgroundColor: colors.primary,
    );
  }

  static Widget navigationIconButton(
    BuildContext context,
    Widget Function()? getDestination,
    IconData icon,
  ) {
    return IconButton(
      onPressed: getDestination != null
          ? () => context.navigator.navigateTo(getDestination())
          : null,
      icon: Icon(icon),
    );
  }
}
