import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class PageComponentFactory {
  static Widget scaffold(
    BuildContext context, {
    required AppBar appBar,
    required Widget body,
  }) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.all(context.constants.spacing),
        child: body,
      ),
    );
  }

  static AppBar appBar(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
  }) {
    CustomColors colors = context.colors;
    IconThemeData iconTheme =
        context.themeData.iconTheme.copyWith(color: context.colors.onPrimary);
    return AppBar(
      toolbarHeight: 35,
      titleTextStyle:
          context.textTheme.headlineSmall?.copyWith(color: colors.onPrimary),
      title: Text(title),
      actionsIconTheme: iconTheme,
      actions: actions,
      iconTheme: iconTheme.copyWith(size: 20),
      backgroundColor: colors.primary,
    );
  }

  static Widget navigationIconButton(BuildContext context, Widget destination){
    return IconButton(
      onPressed: () => context.navigator.navigateTo(destination),
      icon: Icon(context.icons.settings),
    );
  }

  
}
