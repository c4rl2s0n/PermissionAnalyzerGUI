import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    required this.title,
    required this.settings,
    super.key,
  });

  final String title;
  final List<Widget> settings;

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: context.textTheme.headlineSmall),
      Margin.vertical(context.constants.largeSpacing),
      ...settings.insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
    ],
    );
  }
}
