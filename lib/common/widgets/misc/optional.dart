import 'package:flutter/material.dart';

class Optional extends StatelessWidget {
  const Optional({required this.buildOptional, required this.child, this.useOptional=true, super.key});

  final Widget Function(Widget) buildOptional;
  final Widget child;
  final bool useOptional;

  @override
  Widget build(BuildContext context) {
    if(useOptional){
      return buildOptional(child);
    }
    return child;
  }
}
