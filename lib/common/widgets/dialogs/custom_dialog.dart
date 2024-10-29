import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class CustomDialog<T> extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    this.titleTrailing,
    this.icon,
    this.actions,
    this.expand = true,
    super.key,
  });

  final String title;
  final Widget? titleTrailing;
  final Widget content;
  final Widget? icon;
  final List<Widget>? actions;
  final bool expand;

  final double maxTitleWidgetHeight = 28;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.surface,
      insetPadding: EdgeInsets.all(context.constants.spacing),
      title: Row(
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconTheme.of(context).copyWith(size: maxTitleWidgetHeight),
              child: icon!,
            ),
            Margin.horizontal(context.constants.spacing)
          ],
          Text(
            title,
            softWrap: true,
            maxLines: 2,
          ),
          if (titleTrailing != null) ...[
            Margin.horizontal(context.constants.spacing),
            SizedBox(height: maxTitleWidgetHeight, child: titleTrailing!),
          ],
        ],
      ),
      content: Builder(builder: (context) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            expand
                ? Expanded(child: content)
                : Container(
                    constraints: BoxConstraints(
                      maxHeight: mediaQuery.size.height * 0.6,
                    ),
                    child: content,
                  ),
            if (actions != null) ..._buildActions(context),
          ].insertBetweenItems(() => Margin.vertical(context.constants.smallSpacing)),
        );
      }),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    assert(actions != null);
    return [
      Margin.vertical(context.constants.spacing),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions!,
      ),
    ];
  }
}
