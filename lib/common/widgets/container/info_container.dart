import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    this.title,
    required this.child,
    this.width,
    this.height,
    this.scrollable,
    super.key,
  });

  final String? title;
  final Widget child;
  final double? width;
  final double? height;
  final bool? scrollable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(
            title!,
            style: context.textTheme.labelLarge,
          )
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

  Widget _buildChild(){
    Widget c = child;
    if(scrollable == true){
      c = ScrollContainer(
          scrollbarOrientation: ScrollbarOrientation.right,
          scrollDirection: Axis.vertical,
          child: c);
    }
    return c;
  }
}
