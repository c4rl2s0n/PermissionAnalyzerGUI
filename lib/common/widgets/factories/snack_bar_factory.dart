import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';

extension SnackBarTextTheme on BuildContext {
  TextStyle? get messageStyle => textTheme.bodyMedium;
}

class SnackBarFactory {
  static void showSnackbar(
      SnackBar Function(BuildContext context) buildSnackbar) {
    BuildContext? context = messengerKey.currentContext;
    if (context == null) {
      LoggingService.onError(const FlutterErrorDetails(
          exception: "No context for SnackBar...", library: "SnackBarFactory"));
      return;
    }
    messengerKey.currentState?.showSnackBar(buildSnackbar(context));
  }

  static void showPositiveSnackbar(String message) =>
      showSnackbar((c) => getPositiveSnackBar(c, text: message));
  static void showWarningSnackbar(String message) =>
      showSnackbar((c) => getWarningSnackBar(c, text: message));
  static void showNegativeSnackbar(String message) =>
      showSnackbar((c) => getNegativeSnackBar(c, text: message));
  static void showInfoSnackbar(String message) =>
      showSnackbar((c) => getInfoSnackBar(c, text: message));

  static SnackBar _basicSnackBar(
    BuildContext context, {
    required String text,
    IconData? icon,
    Color? textColor,
    Color? snackBarColor,
  }) {
    return SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(icon != null)...[
            Icon(icon, color: textColor,),
            Margin.horizontal(context.constants.spacing),
          ],
          Expanded(
            child: Text(
              text,
              style: context.messageStyle?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: context.constants.borderRadius),
      padding: EdgeInsets.all(context.constants.spacing),
      showCloseIcon: true,
      backgroundColor: snackBarColor,
    );
  }

  static SnackBar getInfoSnackBar(
    BuildContext context, {
    required String text,
  }) =>
      _basicSnackBar(
        context,
        text: text,
        icon: context.icons.info,
        textColor: context.colors.onSurface,
        snackBarColor: context.colors.surfaceContainerHighest,
      );

  static SnackBar getPositiveSnackBar(
    BuildContext context, {
    required String text,
  }) =>
      _basicSnackBar(
        context,
        text: text,
        icon: context.icons.infoPositive,
        textColor: context.colors.onPositive,
        snackBarColor: context.colors.positive,
      );

  static SnackBar getWarningSnackBar(
    BuildContext context, {
    required String text,
  }) =>
      _basicSnackBar(
        context,
        text: text,
        icon: context.icons.warning,
        textColor: context.colors.onWarning,
        snackBarColor: context.colors.warning,
      );

  static SnackBar getNegativeSnackBar(
    BuildContext context, {
    required String text,
  }) =>
      _basicSnackBar(
        context,
        text: text,
        icon: context.icons.infoNegative,
        textColor: context.colors.onNegative,
        snackBarColor: context.colors.negative,
      );
}
