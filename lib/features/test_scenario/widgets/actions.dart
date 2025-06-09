import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class TestScenarioActions extends StatelessWidget {
  const TestScenarioActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _deleteScenarioButton(),
        _resetScenarioButton(),
        _recordButton(),
        _addConstellationsButton(context),
        _runButton(),
      ],
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
              if (await ConfirmationDialog.ask(context,
                      title: "Are you sure?",
                      content:
                          "Do you want to delete the scenario '${state.name}'?") &&
                  context.mounted) {
                context.navigator.pop();
                await context.testScenarioCubit.delete();
              }
            });
      },
    );
  }

  Widget _resetScenarioButton() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.name != state.name,
      builder: (context, state) {
        return IconTextButton(
            text: "Reset Scenario",
            icon: Icon(context.icons.reset),
            color: context.colors.negative,
            onTap: () async {
              if (await ConfirmationDialog.ask(context,
                      title: "Are you sure?",
                      content:
                          "Do you want to reset the scenario '${state.name}'?") &&
                  context.mounted) {
                await context.testScenarioCubit.reset();
              }
            });
      },
    );
  }

  Widget _recordButton() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.adbDevices != state.adbDevices ||
          oldState.deviceApplications != state.deviceApplications,
      builder: (context, session) {
        return BlocBuilder<TestScenarioCubit, TestScenarioState>(
          buildWhen: (oldState, state) =>
              oldState.hasTests != state.hasTests ||
              oldState.loading != state.loading,
          builder: (context, state) {
            bool deviceConnected = session.deviceConnected(state.device);
            bool appInstalled =
                session.applicationInstalled(state.applicationId);
            bool isEnabled = !state.hasTests && deviceConnected && appInstalled;
            return Optional.tooltip(
              tooltip: state.hasTests
                  ? "Tests have already been recorded for this scenario."
                  : !deviceConnected
                      ? "Target device is not connected."
                      : !appInstalled
                          ? "The application is not installed on the device"
                          : "",
              show: !isEnabled,
              child: IconTextButton(
                onTap: () => context.testScenarioCubit.recordScenario(),
                enabled: isEnabled,
                text: "Record Scenario",
                icon: Icon(context.icons.record),
              ),
            );
          },
        );
      },
    );
  }

  Widget _addConstellationsButton(BuildContext context) {
    return IconTextButton(
      onTap: () async {
        int duplicatesCount =
            await context.testScenarioCubit.addConstellations();
        if (context.mounted && duplicatesCount > 0) {
          InfoDialog.showInfo(
            context,
            title: "Duplicate constellations ignored",
            content:
                "Ignored $duplicatesCount constellations, that already exist.",
          );
        }
      },
      text: "Add Constellations",
      icon: Icon(context.icons.create),
    );
  }

  Widget _runButton() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.adbDevices != state.adbDevices ||
          oldState.deviceApplications != state.deviceApplications,
      builder: (context, session) =>
          BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) =>
            oldState.testConstellations != state.testConstellations,
        builder: (context, state) {
          bool deviceConnected = session.deviceConnected(state.device);
          bool appInstalled = session.applicationInstalled(state.applicationId);
          bool isEnabled = state.testConstellations.isNotEmpty &&
              deviceConnected &&
              appInstalled;
          return Optional.tooltip(
            tooltip: state.testConstellations.isEmpty
                ? "No test constellations are defined"
                : !deviceConnected
                    ? "Target device is not connected."
                    : !appInstalled
                        ? "The application is not installed on the device"
                        : "",
            show: !isEnabled,
            child: IconTextButton(
              onTap:
                  isEnabled ? () => context.testScenarioCubit.runTests() : null,
              text: "Run Tests",
              icon: Icon(context.icons.run),
            ),
          );
        },
      ),
    );
  }
}
