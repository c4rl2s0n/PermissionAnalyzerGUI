import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class DeclineButton extends StatelessWidget {
  const DeclineButton({this.returnValue = false, this.text = "No", super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return IconTextButton(
      onTap: () => Navigator.maybePop(
        context,
        returnValue,
      ),
      icon: Icon(context.icons.cancel),
      text: text,
    );
  }
}
