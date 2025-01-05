import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import '../logic/logic.dart';

class ScenarioDetails extends StatelessWidget {
  const ScenarioDetails({super.key});

  final double textFieldWidth = 240;
  final double dropDownWidth = 330;
  final double leftColumnWidth = 350;

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      title: "Details",
      action: _deviceIndicator(context),
      child: Form(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: leftColumnWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _scenarioName(),
                  //_inputDeviceSelection(),
                  _networkInterfaceSelection(),
                  _hasUserInputRecordedIndicator(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _duration(),
                      _numTestRuns(),
                    ],
                  ),
                ].insertBetweenItems(
                  () => Margin.vertical(context.constants.spacing),
                ),
              ),
            ),
            Margin.horizontal(context.constants.largeSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _appId(),
                  _appName(),
                  // _duration(),
                  // _numTestRuns(),
                  //RecordingOptions(),
                  _recordingOptions(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _deviceIndicator(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, session) {
        return BlocBuilder<TestScenarioCubit, TestScenarioState>(
            builder: (context, state) {
          bool deviceConnected = session.deviceConnected(state.device);
          return Tooltip(
            message: deviceConnected
                ? "The device is connected."
                : "The device is NOT connected.",
            child: Text(
              state.device,
              style: context.textTheme.labelLarge?.copyWith(
                  color: deviceConnected
                      ? context.colors.positive
                      : context.colors.negative),
            ),
          );
        });
      },
    );
  }

  Widget _scenarioName() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.name != state.name,
      builder: (context, state) {
        return SizedBox(
          width: leftColumnWidth,
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
          oldState.adbDevices != state.adbDevices ||
          oldState.adbDeviceEventInputs != state.adbDeviceEventInputs,
      builder: (context, session) {
        return BlocBuilder<TestScenarioCubit, TestScenarioState>(
          buildWhen: (oldState, state) =>
              oldState.deviceInput != state.deviceInput ||
              oldState.hasTests != state.hasTests ||
              oldState.hasInputRecord != state.hasInputRecord,
          builder: (context, state) {
            bool deviceConnected = session.deviceConnected(state.device);
            bool dropdownEnabled =
                !state.hasInputRecord && !state.hasTests && deviceConnected;

            List<AndroidInputDevice> inputDevices =
                List.of(session.adbDeviceEventInputs);
            if (!inputDevices.any((i) => i.path == state.deviceInput.path)) {
              inputDevices.insert(0, state.deviceInput);
            }
            inputDevices.sort((a, b) => a.name.compareTo(b.name));

            // Dropdown widget here
            return SizedBox(
              width: leftColumnWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Optional.tooltip(
                    tooltip: state.hasInputRecord
                        ? "Some input has already been recorded."
                        : state.hasTests
                            ? "Tests have already been recorded for this scenario."
                            : !deviceConnected
                                ? "The required device is not connected."
                                : "",
                    show: !dropdownEnabled,
                    child: DropdownMenu<AndroidInputDevice>(
                      key: const Key("InputDeviceSelection"),
                      width: state.deviceInput.info.isNotEmpty
                          ? leftColumnWidth - 50
                          : leftColumnWidth,
                      enabled: dropdownEnabled,
                      enableSearch: false,
                      label: const Text("Input Device"),
                      onSelected: (i) => i == null
                          ? null
                          : context.testScenarioCubit.setEventInputDevice(i),
                      initialSelection: state.deviceInput,
                      requestFocusOnTap: false,
                      dropdownMenuEntries: inputDevices
                          .map((i) => DropDownMenuFactory.dropdownMenuEntry(
                                context,
                                value: i,
                                label: i.name,
                              ))
                          .toList(),
                    ),
                  ),
                  Optional.collapsed(
                    collapse: state.deviceInput.info.isEmpty,
                    child: IconButton(
                      onPressed: () => InfoDialog.showInfo(
                        context,
                        title: "Input Device: ${state.deviceInput.name}",
                        content: state.deviceInput.info,
                      ),
                      icon: Icon(context.icons.info),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _networkInterfaceSelection() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) => oldState.tsharkPath != state.tsharkPath,
      builder: (context, settings) => BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) =>
            oldState.adbDevices != state.adbDevices ||
            oldState.networkInterfaces != state.networkInterfaces,
        builder: (context, session) {
          return BlocBuilder<TestScenarioCubit, TestScenarioState>(
            buildWhen: (oldState, state) =>
                oldState.networkInterface != state.networkInterface ||
                oldState.hasTests != state.hasTests,
            builder: (context, state) {
              bool deviceFound = session.deviceConnected(state.device);
              bool isEnabled = settings.tsharkPath.isNotEmpty &&
                  !state.hasTests &&
                  deviceFound;

              // Widget
              return Optional.tooltip(
                tooltip: settings.tsharkPath.isEmpty
                    ? "The path of the TShark executable needs to be defined in the settings."
                    : state.hasTests
                        ? "Tests have already been recorded for this scenario."
                        : !deviceFound
                            ? "The required device is not connected."
                            : "",
                show: !isEnabled,
                child: DropdownMenu<TsharkNetworkInterface>(
                  key: const Key("NetworkInterfaceSelection"),
                  width: leftColumnWidth,
                  enabled: isEnabled,
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _duration() {
    String? validateDuration(String? s) {
      if (s == null) return null;
      int? seconds = int.tryParse(s);
      if (seconds == null) return "Please enter a valid number";
      if (seconds <= 0) return "Please enter a positive number";
      if (seconds > 180) {
        //return "The maximum duration for screen recording is 180 seconds";
      }
      return null;
    }

    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.duration != state.duration ||
          oldState.recordScreen != state.recordScreen ||
          oldState.hasInputRecord != state.hasInputRecord ||
          oldState.hasTests != state.hasTests,
      builder: (context, state) {
        bool isEnabled = !state.hasInputRecord && !state.hasTests;
        return SizedBox(
          width: textFieldWidth * 2 / 3,
          child: Alternative(
            buildA: (child) => Optional.tooltip(
              tooltip:
                  "The maximum duration for screen recording is 180 seconds",
              show: state.recordScreen,
              child: child,
            ),
            buildB: (child) => Optional.tooltip(
              tooltip: state.hasInputRecord
                  ? "Some replay-input has already been recorded for the specified duration."
                  : state.hasTests
                      ? "Tests have already been recorded for this scenario."
                      : "",
              show: !isEnabled,
              child: child,
            ),
            useB: !isEnabled,
            // Duration text field
            child: SimpleTextField(
              enabled: isEnabled,
              initialValue: state.duration.inSeconds.toString(),
              validate: validateDuration,
              onChanged: (s) =>
                  context.testScenarioCubit.setDuration(int.parse(s)),
              labelText: "Test Duration",
            ),
          ),
        );
      },
    );
  }

  Widget _numTestRuns() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.numTestRuns != state.numTestRuns ||
          oldState.hasTests != state.hasTests,
      builder: (context, state) {
        String? validateNumTestRuns(String? s) {
          if (s == null) return null;
          int? numTests = int.tryParse(s);
          if (numTests == null) return "Please enter a valid number";
          if (numTests <= 0) return "Please enter a positive number";
          int minNum = state.numTestsPerformed;
          if (state.hasTests && numTests < minNum) {
            return "Minimum number is $minNum.";
          }
          return null;
        }

        return SizedBox(
          width: textFieldWidth * 2 / 3,
          child: SimpleTextField(
            initialValue: state.numTestRuns.toString(),
            validate: validateNumTestRuns,
            onChanged: (s) =>
                context.testScenarioCubit.setNumTestRuns(int.parse(s)),
            labelText: "# Test Runs",
          ),
        );
      },
    );
  }

  Widget _hasUserInputRecordedIndicator() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.hasInputRecord != state.hasInputRecord ||
          oldState.hasTests != state.hasTests,
      builder: (context, state) {
        return SizedBox(
          width: leftColumnWidth,
          child: Row(
            children: [
              Text(
                "${!state.hasInputRecord ? " (EMPTY) " : ""}User Input Recorded",
              ),
              if (state.hasInputRecord) ...[
                Optional.tooltip(
                  tooltip:
                      "Tests have already been recorded for this scenario.",
                  show: state.hasTests,
                  child: IconButton(
                    onPressed: state.hasInputRecord && !state.hasTests
                        ? () async {
                            if (state.hasTests) {
                              await InfoDialog.showInfo(context,
                                  title: "Tests exist",
                                  content:
                                      "Tests have already been performed.\nCannot delete recorded user input.");
                            } else if (await ConfirmationDialog.ask(
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
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// #####################
  /// ## Recording Options
  /// #####################

  Widget _recordingOptions(BuildContext context) {
    return SizedBox(
      width: textFieldWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recording Options",
              style: context.textTheme.labelMedium?.copyWith(
                  color: context.textTheme.labelMedium?.color
                      ?.withOpacity(context.constants.lightColorOpacity))),
          SizedBox(width: textFieldWidth, child: _recordScreen(context)),
          SizedBox(
              width: textFieldWidth, child: _captureNetworkTraffic(context)),
        ],
      ),
    );
  }

  Widget _recordScreen(BuildContext context) {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.recordScreen != state.recordScreen,
      builder: (context, state) {
        return _boolSetting(
          context,
          name: "Record Screen",
          value: state.recordScreen,
          onToggle: () => context.testScenarioCubit.toggleRecordScreen(),
        );
      },
    );
  }

  Widget _captureNetworkTraffic(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) =>
          BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) =>
            oldState.captureTraffic != state.captureTraffic,
        builder: (context, state) {
          bool isEnabled = settings.tsharkPath.isNotEmpty;
          return Optional.tooltip(
            tooltip:
                "The path of the TShark executable needs to be defined in the settings.",
            show: !isEnabled,
            child: _boolSetting(
              context,
              name: "Capture Network Traffic",
              value: state.captureTraffic,
              onToggle: () => context.testScenarioCubit.toggleCaptureTraffic(),
              enabled: isEnabled,
            ),
          );
        },
      ),
    );
  }

  Widget _boolSetting(
    BuildContext context, {
    required String name,
    required bool value,
    void Function()? onToggle,
    bool enabled = true,
  }) {
    return TapContainer(
      backgroundColor: Colors.transparent,
      onTap: onToggle != null ? (_) => onToggle() : null,
      enabled: enabled,
      padding: EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          Icon(value
              ? context.icons.checkboxSelected
              : context.icons.checkboxDeselected),
        ],
      ),
    );
  }
}
