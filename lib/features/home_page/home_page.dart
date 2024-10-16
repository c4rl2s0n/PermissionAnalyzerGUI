import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/features/settings_page/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.getScaffold(
      context,
      appBar: PageComponentFactory.getAppBar(
        context,
        title: context.strings.home,
        actions: [
          IconButton(
            onPressed: () => context.navigator.navigateTo(const SettingsPage()),
            icon: Icon(context.icons.settings),
          )
        ],
      ),
      body: SizedBox(),
    );
  }
}
