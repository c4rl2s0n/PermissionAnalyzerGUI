import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';


class ConfirmButton extends StatelessWidget{

  const ConfirmButton({this.returnValue = true, this.text = "Okay", super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return IconTextButton(
      onTap: () => Navigator.maybePop(
        context,
        returnValue,
      ),
      icon: Icon(context.icons.check),
      text: text,
      color: context.colors.positive,
    );
  }

}