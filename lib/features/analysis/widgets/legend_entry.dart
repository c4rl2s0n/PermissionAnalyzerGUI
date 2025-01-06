import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class LegendEntry extends StatelessWidget {
  const LegendEntry({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.maxTextLength = 20,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final int maxTextLength;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    bool textTooLong = text.length > maxTextLength;
    String displayedText = text.substring(0, min(maxTextLength, text.length));
    if(textTooLong) displayedText += "...";
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: context.constants.spacing),
        Optional.tooltip(
          tooltip: text,
          show: textTooLong,
          child: Text(
            displayedText,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}