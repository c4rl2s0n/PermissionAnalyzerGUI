import 'package:flutter/material.dart';

import 'package:flutter_template/common/common.dart';

class SnackBarFactory {
  static SnackBar getInfoSnackBar(
    BuildContext context, {
    required String text,
  }) {
    return SnackBar(
      content: Text(
        text,
      ),
    );
  }

  static SnackBar getPositiveSnackBar(
    BuildContext context, {
    required String text,
  }) {
    return SnackBar(
      content: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.black,
        ),
      ),
      backgroundColor: context.colors.positive,
    );
  }

  static SnackBar getWarningSnackBar(
    BuildContext context, {
    required String text,
  }) {
    return SnackBar(
      content: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.black,
        ),
      ),
      backgroundColor: context.colors.warning,
    );
  }
}
