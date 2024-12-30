import 'package:flutter/material.dart';

class Alternative extends StatelessWidget {
  const Alternative({
    required this.buildA,
    required this.buildB,
    required this.child,
    this.useB = false,
    super.key,
  });

  Alternative.direct({
    required Widget A,
    required Widget B,
    bool useB = false,
    Key? key,
  }) : this(
          buildA: (_) => A,
          buildB: (_) => B,
          child: const SizedBox.shrink(),
          useB: useB,
          key: key,
        );

  final Widget Function(Widget) buildA;
  final Widget Function(Widget) buildB;
  final Widget child;
  final bool useB;

  @override
  Widget build(BuildContext context) {
    if (useB) {
      return buildB(child);
    }
    return buildA(child);
  }
}
