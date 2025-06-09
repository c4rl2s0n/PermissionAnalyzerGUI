import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class SimpleSetting extends StatelessWidget {
  const SimpleSetting({
    required this.name,
    this.description,
    this.action,
    super.key,
  });

  final String name;
  final String? description;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.textTheme.titleMedium,
              ),
              if (description != null) ...[
                Text(
                  description!,
                  style: context.textTheme.labelMedium,
                )
              ],
            ],
          ),
        ),
        if (action != null) ...[Flexible(flex: 1, child: action!)],
      ],
    );
  }
}
