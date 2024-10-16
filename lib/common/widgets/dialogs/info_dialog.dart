import 'package:flutter/material.dart';

import 'package:flutter_template/common/common.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    required this.title,
    required this.content,
    required this.icon,
    super.key,
  });

  final String title;
  final String content;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      content: SingleChildScrollView(child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(data: IconTheme.of(context).copyWith(size: 42), child: icon),
          SizedBox(width: context.constants.spacing),
          Expanded(child: Text(content, softWrap: true,))
        ],
      )),
      actions: const [
        ConfirmButton(),
      ],
      expand: false,
    );
  }

  static Future<bool> showInfo(
      BuildContext context, {
        String? title,
        String? content,
        Icon? icon,
      }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InfoDialog(
        title: title ?? "Did you know this?",
        content: content ?? "So much information...",
        icon: icon ?? Icon(context.icons.info,),
      ),
    );
  }
}
