import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    this.title,
    required this.child,
    this.width,
    this.height,
    this.headerHeight = 30,
    this.scrollable,
    this.action,
    super.key,
  });

  final String? title;
  final Widget child;
  final double? width;
  final double? height;
  final double? headerHeight;
  final bool? scrollable;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title!.isNotEmpty || action != null) ...[
          _headerRow(context),
        ],
        Flexible(
          child: Container(
            padding: EdgeInsets.all(context.constants.spacing),
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.onBackground),
              borderRadius:
                  BorderRadius.all(context.constants.roundedCornerRadius),
            ),
            child: _buildChild(),
          ),
        ),
      ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
    );
  }

  Widget _headerRow(BuildContext context) {
    return SizedBox(
      height: headerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: context.textTheme.labelLarge,
            ),
          ],
          if (action != null) ...[
            action!,
          ],
        ],
      ),
    );
  }

  Widget _buildChild() {
    Widget c = child;
    if (scrollable == true) {
      c = ScrollContainer(
          scrollbarOrientation: ScrollbarOrientation.right,
          scrollDirection: Axis.vertical,
          child: c);
    }
    return c;
  }
}
