
import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';

class PageComponentFactory{
  static Widget getScaffold(BuildContext context, {required AppBar appBar, required Widget body}){
    return Scaffold(
        backgroundColor: context.colors.background,
        appBar: appBar,
        body: Padding(
          padding: EdgeInsets.all(context.constants.spacing),
          child: body,
        ),
    );
  }
  static AppBar getAppBar(BuildContext context, {required String title, List<Widget>? actions}){
    CustomColors colors = context.colors;
    IconThemeData iconTheme = context.themeData.iconTheme.copyWith(color: context.colors.onPrimary);
    return AppBar(
      titleTextStyle: context.textTheme.displayMedium?.copyWith(color: colors.onPrimary),
      title: Text(title),
      actionsIconTheme: iconTheme,
      actions: actions,
      iconTheme: iconTheme,
      backgroundColor: colors.primary,
    );
  }
}