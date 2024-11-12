import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import '../logic/logic.dart';

class ScenarioDetails extends StatelessWidget {
  const ScenarioDetails({super.key});

  final double textFieldWidth = 200;
  final double dropDownWidth = 330;

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      title: "Details",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(child: _scenarioName()),
              Margin.horizontal(context.constants.largeSpacing),
              _appId(),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _inputDeviceSelection()),
              Margin.horizontal(context.constants.largeSpacing),
              _appName(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: _networkInterfaceSelection()),
              Margin.horizontal(context.constants.spacing),
              _duration(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _hasUserInputRecordedIndicator(),
              _numTestRuns(),
            ],
          ),
        ].insertBetweenItems(
          () => Margin.vertical(context.constants.spacing),
        ),
      ),
    );
  }

  Widget _scenarioName() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.name != state.name,
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: SimpleTextField(
            initialValue: state.name,
            onChanged: (s) => context.testScenarioCubit.setName(s),
            labelText: "Name",
          ),
        );
      },
    );
  }

  Widget _appId() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.applicationId != state.applicationId,
      builder: (context, state) {
        return SizedBox(
          width: textFieldWidth,
          child: SimpleTextField(
            enabled: false,
            initialValue: state.applicationId,
            labelText: "Application-ID",
          ),
        );
      },
    );
  }

  Widget _appName() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.applicationName != state.applicationName,
      builder: (context, state) {
        return SizedBox(
          width: textFieldWidth,
          child: SimpleTextField(
            enabled: false,
            initialValue: state.applicationName,
            labelText: "Application-Name",
          ),
        );
      },
    );
  }

  Widget _inputDeviceSelection() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.adbDeviceEventInputs != state.adbDeviceEventInputs,
      builder: (context, session) {
        return BlocBuilder<TestScenarioCubit, TestScenarioState>(
          buildWhen: (oldState, state) =>
              oldState.deviceInput != state.deviceInput ||
              oldState.hasInputRecord != state.hasInputRecord,
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<AndroidInputDevice>(
                  key: const Key("InputDeviceSelection"),
                  width: dropDownWidth,
                  enabled: !state.hasInputRecord,
                  label: const Text("Input Device"),
                  onSelected: (i) => i == null
                      ? null
                      : context.testScenarioCubit.setEventInputDevice(i),
                  initialSelection: state.deviceInput,
                  requestFocusOnTap: false,
                  dropdownMenuEntries: session.inputDevices
                      .map((i) => DropDownMenuFactory.dropdownMenuEntry(
                            context,
                            value: i,
                            label: i.name,
                          ))
                      .toList(),
                ),
                IconButton(
                  onPressed: state.deviceInput.info.isNotEmpty
                      ? () => InfoDialog.showInfo(
                            context,
                            title: "Input Device: ${state.deviceInput.name}",
                            content: state.deviceInput.info,
                          )
                      : null,
                  icon: Icon(context.icons.info),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _networkInterfaceSelection() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.networkInterfaces != state.networkInterfaces,
      builder: (context, session) {
        return BlocBuilder<TestScenarioCubit, TestScenarioState>(
          buildWhen: (oldState, state) =>
              oldState.networkInterface != state.networkInterface ||
              oldState.hasTests != state.hasTests,
          builder: (context, state) {
            return DropdownMenu<TsharkNetworkInterface>(
              key: const Key("NetworkInterfaceSelection"),
              width: dropDownWidth,
              enabled: !state.hasTests,
              label: const Text("Network Interface"),
              onSelected: (i) => i == null
                  ? null
                  : context.testScenarioCubit.setNetworkInterface(i),
              initialSelection: state.networkInterface,
              requestFocusOnTap: false,
              dropdownMenuEntries: session.networkInterfaces
                  .map((i) => DropDownMenuFactory.dropdownMenuEntry(
                        context,
                        value: i,
                        label: i.name,
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }

  Widget _duration() {
    String? validateDuration(String? s) {
      if (s == null) return null;
      int? seconds = int.tryParse(s);
      if (seconds == null) return "Please enter a valid number";
      if (seconds <= 0) return "Please enter a positive number";
      if (seconds > 180) {
        return "The maximum duration for screen recording is 180 seconds";
      }
      return null;
    }

    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.duration != state.duration ||
          oldState.hasInputRecord != state.hasInputRecord,
      builder: (context, state) => SizedBox(
        width: textFieldWidth,
        child: SimpleTextField(
          enabled: !state.hasInputRecord,
          initialValue: state.duration.inSeconds.toString(),
          validate: validateDuration,
          onChanged: (s) => context.testScenarioCubit.setDuration(int.parse(s)),
          labelText: "Test Duration",
        ),
      ),
    );
  }

  Widget _numTestRuns() {
    String? validateNumTestRuns(String? s) {
      if (s == null) return null;
      int? seconds = int.tryParse(s);
      if (seconds == null) return "Please enter a valid number";
      if (seconds <= 0) return "Please enter a positive number";
      return null;
    }

    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.numTestRuns != state.numTestRuns,
      builder: (context, state) => SizedBox(
        width: textFieldWidth,
        child: SimpleTextField(
          initialValue: state.numTestRuns.toString(),
          validate: validateNumTestRuns,
          onChanged: (s) =>
              context.testScenarioCubit.setNumTestRuns(int.parse(s)),
          labelText: "# Test Runs",
        ),
      ),
    );
  }

  Widget _hasUserInputRecordedIndicator() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.hasInputRecord != state.hasInputRecord ||
          oldState.hasTests != state.hasTests,
      builder: (context, state) {
        return Row(
          children: [
            Text(
              "${!state.hasInputRecord ? " (EMPTY) " : ""}User Input Recorded",
            ),
            if (state.hasInputRecord) ...[
              IconButton(
                onPressed: state.hasInputRecord && !state.hasTests
                    ? () async {
                        if (await ConfirmationDialog.ask(
                              context,
                              content:
                                  "Do you want to reset the recorded user input?",
                            ) &&
                            context.mounted) {
                          context.testScenarioCubit.resetUserInput();
                        }
                      }
                    : null,
                icon: Icon(
                  context.icons.remove,
                  color: context.colors.negative,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
