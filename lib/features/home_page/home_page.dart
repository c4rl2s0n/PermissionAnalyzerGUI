import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/settings_page/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: context.strings.home,
        actions: [
          IconButton(
            onPressed: () => context.navigator.navigateTo(const SettingsPage()),
            icon: Icon(context.icons.settings),
          )
        ],
      ),
      body: const SizedBox(),
    );
  }
}
