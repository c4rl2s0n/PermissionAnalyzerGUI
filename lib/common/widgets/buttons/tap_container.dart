import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class TapContainer extends StatelessWidget {
  const TapContainer({this.onTap, this.child, this.backgroundColor, this.splashColor, this.padding, super.key});

  final Widget? child;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? splashColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
      child: InkWell(
          borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
          splashColor: splashColor ?? context.colors.secondary,
          highlightColor: context.colors.highlight,
          hoverColor:
              context.colors.onBackground.withOpacity(context.constants.strongColorOpacity),
          splashFactory: InkRipple.splashFactory,
          onTap:
              onTap != null ? () => performDelayedTap(context, onTap!) : null,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          )),
    );
  }
}
