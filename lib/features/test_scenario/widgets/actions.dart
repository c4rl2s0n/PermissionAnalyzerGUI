import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class TestScenarioActions extends StatelessWidget {
  const TestScenarioActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
      oldState.hasTests != state.hasTests ||
          oldState.canRun != state.canRun,
      builder: (context, state) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _deleteScenarioButton(),
              _recordButton(),
              _createConstellationsButton(),
              _runButton(),
            ],
          ),
    );
  }

  Widget _deleteScenarioButton() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.name != state.name,
      builder: (context, state) {
        return IconTextButton(
            text: "Delete Scenario",
            icon: Icon(context.icons.remove),
            color: context.colors.negative,
            onTap: () async {
              if (await ConfirmationDialog.ask(context, title: "Are you sure?",
                  content: "Do you want to delete the scenario '${state
                      .name}'?") && context.mounted) {
                context.navigator.pop();
                await context.testScenarioCubit.delete();
              }
            }
        );
      },
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
