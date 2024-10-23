import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      content: SingleChildScrollView(
          child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconTheme.of(context).copyWith(size: 42),
            child: Icon(context.icons.question),
          ),
          SizedBox(width: context.constants.spacing),
          Expanded(
              child: Text(
            content,
            softWrap: true,
          ))
        ],
      )),
      actions: const [
        DeclineButton(),
        ConfirmButton(),
      ],
      expand: false,
    );
  }

  static Future<bool> ask(
      BuildContext context, {
        String? title,
        String? content,
      }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        title: title ?? "Do you trust this?",
        content: content ?? "",
      ),
    );
  }
}
