import 'package:flutter/material.dart';

import 'package:flutter_template/common/common.dart';

class TapContainer extends StatelessWidget {
  const TapContainer({this.onTap, this.child, this.backgroundColor, this.splashColor, super.key});

  final Widget? child;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? context.colors.primary.withOpacity(context.constants.subtleColorOpacity),
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
          child: child),
    );
  }
}
