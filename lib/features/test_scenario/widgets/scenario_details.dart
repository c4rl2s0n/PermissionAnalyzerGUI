import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class ScenarioDetails extends StatelessWidget {
  const ScenarioDetails({super.key});

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
              Expanded(child: _appId()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _inputDeviceSelection(),
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
        return SimpleTextField(
          initialValue: state.name,
          onChanged: (s) => context.testScenarioCubit.setName(s),
          labelText: "Name",
        );
      },
    );
  }
  Widget _appId() {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.applicationId != state.applicationId,
      builder: (context, state) {
        return SimpleTextField(
          initialValue: state.applicationId,
          onChanged: context.testScenarioCubit.setApplicationId,
          labelText: "Application-ID",
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
              oldState.inputDevice != state.inputDevice ||
              oldState.inputDeviceInfo != state.inputDeviceInfo ||
              oldState.hasInputRecord != state.hasInputRecord,
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AbsorbPointer(
                  absorbing: state.hasInputRecord,
                  child: DropdownMenu(
                    label: const Text("Input Device"),
                    onSelected: (i) => i == null
                        ? null
                        : context.testScenarioCubit
                            .setEventDevice(i, session.inputDeviceInfo(i)),
                    initialSelection: state.inputDevice,
                    requestFocusOnTap: false,
                    dropdownMenuEntries: session.inputDevices
                        .map((i) => DropdownMenuEntry(value: i, label: i))
                        .toList(),
                  ),
                ),
                IconButton(
                  onPressed: state.inputDeviceInfo.isNotEmpty
                      ? () => InfoDialog.showInfo(
                            context,
                            title: "Input Device: ${state.inputDevice}",
                            content: state.inputDeviceInfo,
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
      builder: (context, state) => AbsorbPointer(
        absorbing: state.hasInputRecord,
        child: SizedBox(
          width: 150,
          child: SimpleTextField(
            initialValue: state.duration.inSeconds.toString(),
            validate: validateDuration,
            onChanged: (s) =>
                context.testScenarioCubit.setDuration(int.parse(s)),
            labelText: "Test Duration",
          ),
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
      buildWhen: (oldState, state) =>
          oldState.duration != state.duration ||
          oldState.hasInputRecord != state.hasInputRecord,
      builder: (context, state) => SizedBox(
        width: 150,
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
          oldState.hasInputRecord != state.hasInputRecord,
      builder: (context, state) {
        return Row(
          children: [
            Text("${!state.hasInputRecord ? " (REQUIRED) " : ""}User Input Recorded"),
            if (state.hasInputRecord) ...[
              // TODO: Ask for confirmation before deleting anything!
              IconButton(
                onPressed: state.hasInputRecord
                    ? context.testScenarioCubit.resetUserInput
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
