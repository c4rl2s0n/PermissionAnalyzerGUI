import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    this.icon,
    this.text,
    this.textStyle,
    this.enabled = true,
    this.onTap,
    this.loading = false,
    this.color,
    this.padding,
    super.key,
  });

  final Icon? icon;
  final String? text;
  final TextStyle? textStyle;
  final bool enabled;
  final Function()? onTap;
  final bool loading;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    Color color = onTap == null || !enabled
        ? context.colors.disabled
        : this.color ?? context.colors.highlight;
    TextStyle? usedTextStyle =
        textStyle ?? context.textTheme.labelMedium?.copyWith(color: color);
    return TapContainer(
      onTap: enabled ? onTap : null,
      splashColor: color.withOpacity(context.constants.strongColorOpacity),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(padding ?? context.constants.smallSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
          border: Border.all(color: color, width: 2),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading) ...[
              CircularProgressIndicator(color: usedTextStyle?.color),
            ] else if (icon != null) ...[
              IconTheme(
                  data: context.iconTheme.copyWith(color: usedTextStyle?.color),
                  child: icon!)
            ],
            if (icon != null && text != null) ...[
              SizedBox(width: context.constants.spacing)
            ],
            if (text != null) ...[Text(text!, style: usedTextStyle)],
          ],
        ),
      ),
    );
  }
}
