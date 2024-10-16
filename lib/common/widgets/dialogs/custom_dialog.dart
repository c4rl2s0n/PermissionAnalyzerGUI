import 'package:flutter/material.dart';

import 'package:flutter_template/common/common.dart';

class CustomDialog<T> extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    this.actions,
    this.expand = true,
    super.key,
  });

  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        iconTheme: theme.iconTheme.copyWith(color: context.colors.onSurface),
      ),
      child: AlertDialog(
        backgroundColor: context.colors.surface,
        insetPadding: EdgeInsets.all(context.constants.spacing),
        title: Text(
          title,
          softWrap: true,
          maxLines: 2,
        ),
        content: Builder(builder: (context) {
          MediaQueryData mediaQuery = MediaQuery.of(context);
          return SizedBox(
            width: mediaQuery.size.width, // * CustomTheme.dialogSizeScale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                expand
                    ? Expanded(child: content)
                    : Container(
                        constraints: BoxConstraints(
                          maxHeight: mediaQuery.size.height * 0.6,
                        ), // TODO: Properly layout!
                        child: content,
                      ),
                if (actions != null) ..._buildActions(context),
              ],
            ),
          );
        }),
      ),
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
