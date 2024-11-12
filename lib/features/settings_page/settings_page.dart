import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/settings_page/tool_settings.dart';

import 'language_settings.dart';
import 'theme_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar:
          PageComponentFactory.appBar(context, title: context.strings.settings),
      body: ScrollContainer(
        child: Column(
          children: [
            const ThemeSettings(),
            const LanguageSettings(),
            const ToolSettings(),
          ].insertBetweenItems(() => const Divider()).insertBetweenItems(
              () => Margin.vertical(context.constants.largeSpacing)),
        ),
      ),
    );
  }
}
