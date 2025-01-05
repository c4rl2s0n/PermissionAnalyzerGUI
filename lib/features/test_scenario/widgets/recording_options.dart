import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class RecordingOptions extends StatelessWidget {
  const RecordingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.hasTests != state.hasTests,
      builder: (context, state) {
        return Optional.tooltip(
          tooltip: "Tests have already been recorded for this scenario.",
          show: state.hasTests,
          child: AbsorbPointer(
            absorbing: state.hasTests,
            child: InfoContainer(
              title: "Record Settings",
              child: Column(
                children: <Widget>[
                  _recordScreen(context),
                  _captureNetworkTraffic(context),
                ].insertBetweenItems(
                    () => Margin.vertical(context.constants.spacing)),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _recordScreen(BuildContext context){
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
      oldState.recordScreen != state.recordScreen,
      builder: (context, state) {
        return _boolSetting(
          context,
          name: "Record Screen",
          value: state.recordScreen,
          onToggle: () =>
              context.testScenarioCubit.toggleRecordScreen(),
        );
      },
    );
  }
  Widget _captureNetworkTraffic(BuildContext context){
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) => BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) =>
        oldState.captureTraffic != state.captureTraffic,
        builder: (context, state) {
          bool isEnabled = settings.tsharkPath.isNotEmpty;
          return Optional.tooltip(
            tooltip: "The path of the TShark executable needs to be defined in the settings.",
            show: !isEnabled,
            child: _boolSetting(
              context,
              name: "Capture Network Traffic",
              value: state.captureTraffic,
              onToggle: () =>
                  context.testScenarioCubit.toggleCaptureTraffic(),
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
