import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class TestScenario extends StatelessWidget {
  const TestScenario(this.scenario, {super.key});

  final models.TestScenario scenario;

  // TODO:
  //  Set Duration,
  //  Select Permissions,
  //    -> show in directory-like tree-view, make them selectable as fixed given/revoked, or testing (resulting in a testscenario with both permission states)
  //  should Record Screen / capture network traffic

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(context,
          title: context.strings.testScenario,
          actions: [
            PageComponentFactory.navigationIconButton(
              context,
              const SettingsPage(),
            )
          ]),
      body: BlocProvider(
        create: (context) =>
            TestScenarioCubit(
              testScenarioRepository: Modular.get<ITestScenarioRepository>(),
              sessionCubit: context.session,
              settingsCubit: context.settings,
              testScenario: scenario,
            ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocListener<TestScenarioCubit, TestScenarioState>(
      listenWhen: (oldState, state) => oldState.loading != state.loading,
      listener: _onLoading,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ScenarioDetails(),
                      const Expanded(child: TestConstellationsOverview()),
                    ].insertBetweenItems(
                            () => Margin.vertical(context.constants.spacing)),
                  ),
                ),
                // Once tests have been created and were executed, the settings can not be changed anymore!
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: PermissionSelector()),
                      const RecordingOptions(),
                    ].insertBetweenItems(
                          () => Margin.vertical(context.constants.spacing),
                    ),
                  ),
                ),
              ].insertBetweenItems(
                      () => Margin.horizontal(context.constants.largeSpacing)),
            ),
          ),
          _actions(),
        ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
      ),
    );
  }

  void _onLoading(BuildContext context, TestScenarioState state) {
    if (!state.loading) return;
    // open loading dialog
    var cubit = context.testScenarioCubit;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            LoadingDialog(
              cubit,
              title: state.loadingInfo,
            ));
  }

  Widget _actions() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
      oldState.hasTests != state.hasTests ||
          oldState.canRun != state.canRun,
      builder: (context, state) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _deleteScenarioButton(context),
              _recordButton(),
              _createConstellationsButton(),
              _runButton(),
            ],
          ),
    );
  }

  Widget _deleteScenarioButton(BuildContext context) {
    return IconTextButton(
        text: "Delete Scenario",
        icon: Icon(context.icons.remove),
        color: context.colors.negative,
        onTap: () async {
          if(await ConfirmationDialog.ask(context, title: "Are you sure?", content: "Do you want to delete the scenario '${scenario.name}'?") && context.mounted) {
            context.navigator.pop();
            await context.testScenarioCubit.delete();
          }
        }
    );
  }

  Widget _recordButton() {
    return
      BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) => oldState.hasTests != state.hasTests,
        builder: (context, state) {
          return IconTextButton(
            onTap: state.hasTests
                ? null
                : () => context.testScenarioCubit.recordScenario(),
            text: "Record Scenario",
            icon: Icon(context.icons.record),
          );
        },
      );
  }

  Widget _createConstellationsButton() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.hasTests != state.hasTests,
      builder: (context, state) {
        return IconTextButton(
          onTap: state.hasTests
              ? null
              : () => context.testScenarioCubit.createConstellations(),
          text: "Create Constellations",
          icon: Icon(context.icons.create),
        );
      },
    );
  }

  Widget _runButton() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.canRun != state.canRun,
      builder: (context, state) {
        return IconTextButton(
          onTap: state.canRun
              ? () => context.testScenarioCubit.runTests()
              : null,
          text: "Run Tests",
          icon: Icon(context.icons.run),
        );
      },
    );
  }
}
