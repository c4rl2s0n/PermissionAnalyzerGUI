import 'package:flutter/material.dart';

class Optional extends StatelessWidget {
  const Optional({required this.buildOptional, required this.child, this.useOptional=true, super.key});

  Optional.tooltip({required String tooltip, required bool show, required Widget child, Key? key}) : this(buildOptional:(c)=>Tooltip(message: tooltip, child: c), child: child, useOptional: show, key: key);
  Optional.hidden({required bool hide, required Widget child, Key? key}) : this(buildOptional:(c)=>Visibility(visible: false, child: c), child: child, useOptional: hide, key: key);
  Optional.collapsed({required bool collapse, required Widget child, Key? key}) : this(buildOptional:(c)=>c, child: const SizedBox.shrink(), useOptional: !collapse, key: key);

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
