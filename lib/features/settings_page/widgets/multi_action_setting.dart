
import 'package:flutter/material.dart';

import 'simple_setting.dart';

class MultiActionSetting extends StatelessWidget {
  const MultiActionSetting({
    required this.name,
    this.description,
    this.actions,
    super.key,
  });

  final String name;
  final String? description;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return SimpleSetting(
      name: name,
      description: description,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions??[],
      ),
    );
  }
}
