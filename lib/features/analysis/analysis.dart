import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'widgets/widgets.dart';

class Analysis extends StatelessWidget {
  const Analysis(this.scenarios, {super.key});

  final List<models.TestScenario> scenarios;

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      withPadding: false,
      appBar: PageComponentFactory.appBar(context, title: "Analysis", actions: [
        PageComponentFactory.navigationIconButton(
          context,
          () => const SettingsPage(),
          context.icons.settings,
        )
      ]),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return EndpointAnalysis(scenarios: scenarios);
  }
}
