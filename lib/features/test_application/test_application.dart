import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/repositories/repositories.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as model;
import 'package:permission_analyzer_gui/features/features.dart';
import 'package:permission_analyzer_gui/features/test_application/logic/context_extension.dart';

import 'logic/test_application_cubit.dart';

class TestApplication extends StatelessWidget {
  const TestApplication({required this.application, super.key});

  final model.TestApplication application;

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: application.name,
        actions: [
          PageComponentFactory.navigationIconButton(
            context,
            () => const SettingsPage(),
            context.icons.settings,
          )
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocProvider<TestApplicationCubit>(
        create: (context) => TestApplicationCubit(
              application,
              Modular.get<ITestApplicationRepository>(),
              Modular.get<ITestScenarioRepository>(),
            ),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Expanded(child: _overview()),
              _actions(context),
            ].insertBetweenItems(
                () => Margin.vertical(context.constants.spacing)),
          );
        }));
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _deleteApplicationButton(context),
        _newScenarioButton(),
      ],
    );
  }

  Widget _deleteApplicationButton(BuildContext context) {
    return IconTextButton(
        text: "Delete Application",
        icon: Icon(context.icons.remove),
        color: context.colors.negative,
        onTap: () async {
          if (await ConfirmationDialog.ask(context,
                  title: "Are you sure?",
                  content:
                      "Do you want to delete the application '${application.name}'?") &&
              context.mounted) {
            context.navigator.pop();
            await context.testApplicationCubit.delete();
          }
        });
  }

  Widget _newScenarioButton() {
    return BlocBuilder<TestApplicationCubit, TestApplicationState>(
      buildWhen: (oldState, state) => oldState.scenarios != state.scenarios,
      builder: (context, state) => IconTextButton(
          text: "New Scenario",
          icon: Icon(context.icons.add),
          onTap: () async {
            model.TestScenario scenario =
                await context.testApplicationCubit.newScenario();
            if (context.mounted) {
              context.navigator.navigateTo(TestScenario(scenario));
            }
          }),
    );
  }

  Widget _overview() {
    return BlocBuilder<TestApplicationCubit, TestApplicationState>(
      buildWhen: (oldState, state) => oldState.scenarios != state.scenarios,
      builder: (context, state) => InfoContainer(
        title: "Scenarios",
        child: DataGrid(
          columns: [DataGridColumnSetting(name: "Name", width: 100)],
          rows: state.scenarios
              .map(
                (s) => DataGridRow(
                    cells: [Text(s.name)],
                    onTap: () => context.navigator.navigateTo(TestScenario(s))),
              )
              .toList(),
        ),
      ),
    );
  }
}
