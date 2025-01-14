import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class ScrollContainer extends StatefulWidget {
  const ScrollContainer({
    this.scrollbarOrientation = ScrollbarOrientation.right,
    this.scrollDirection = Axis.vertical,
    this.scrollbarAlwaysVisible,
    required this.child,
    super.key,
  });

  final Widget child;
  final bool? scrollbarAlwaysVisible;
  final ScrollbarOrientation scrollbarOrientation;
  final Axis scrollDirection;

  @override
  State<ScrollContainer> createState() => _ScrollContainerState();
}

class _ScrollContainerState extends State<ScrollContainer> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      scrollbarOrientation: widget.scrollbarOrientation,
      controller: _scrollController,
      thumbVisibility: widget.scrollbarAlwaysVisible,
      child: _padding(
        context,
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            primary: false,
            controller: _scrollController,
            scrollDirection: widget.scrollDirection,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _padding(BuildContext context, Widget child) {
    late EdgeInsets padding;
    double paddingValue =
        context.themeData.scrollbarTheme.thickness?.resolve({}) ?? 0;
    paddingValue *= 1.6;
    switch (widget.scrollbarOrientation) {
      case ScrollbarOrientation.bottom:
        padding = EdgeInsets.only(bottom: paddingValue);
        break;
      case ScrollbarOrientation.left:
        padding = EdgeInsets.only(left: paddingValue);
        break;
      case ScrollbarOrientation.top:
        padding = EdgeInsets.only(top: paddingValue);
        break;
      case ScrollbarOrientation.right:
        padding = EdgeInsets.only(right: paddingValue);
        break;
      default:
        padding = EdgeInsets.zero;
    }
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
