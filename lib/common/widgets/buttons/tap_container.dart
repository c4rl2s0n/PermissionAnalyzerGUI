import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class TapContainer extends StatelessWidget {
  const TapContainer({
    this.onTap,
    this.onSecondaryTap,
    this.child,
    this.enabled = true,
    this.backgroundColor,
    this.splashColor,
    this.padding,
    super.key,
  });

  final Widget? child;
  final Function(Offset? position)? onTap;
  final Function(Offset? position)? onSecondaryTap;
  final bool enabled;
  final Color? backgroundColor;
  final Color? splashColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Offset? pointerPosition;
    return Listener(
      onPointerDown: (d) => pointerPosition = d.position,
      child: Material(
        color: !enabled
            ? context.colors.disabled.withOpacity(0.1)
            : backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
        child: InkWell(
            canRequestFocus: false,
            borderRadius:
                BorderRadius.all(context.constants.roundedCornerRadius),
            splashColor: splashColor ?? context.colors.secondary,
            highlightColor: context.colors.highlight,
            hoverColor: context.colors.onBackground
                .withOpacity(context.constants.strongColorOpacity),
            splashFactory: InkRipple.splashFactory,
            onTap: onTap != null && enabled
                ? () =>
                    performDelayedTap(context, () => onTap!(pointerPosition))
                : null,
            onSecondaryTap: onSecondaryTap != null && enabled
                ? () => performDelayedTap(
                    context, () => onSecondaryTap!(pointerPosition))
                : null,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            )),
      ),
    );
  }
}
