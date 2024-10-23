import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class RecordingOptions extends StatelessWidget {
  const RecordingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) => oldState.canConfigure != state.canConfigure,
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: !state.canConfigure,
          child: InfoContainer(
            title: "Record Settings",
            child: Column(
              children: <Widget>[
                BlocBuilder<TestScenarioCubit, TestScenarioState>(
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
                ),
                BlocBuilder<TestScenarioCubit, TestScenarioState>(
                  buildWhen: (oldState, state) =>
                  oldState.captureTraffic != state.captureTraffic,
                  builder: (context, state) {
                    return _boolSetting(
                      context,
                      name: "Capture Network Traffic",
                      value: state.captureTraffic,
                      onToggle: () =>
                          context.testScenarioCubit.toggleCaptureTraffic(),
                    );
                  },
                ),
              ].insertBetweenItems(
                      () => Margin.vertical(context.constants.spacing)),
            ),
          ),
        );
      },
    );
  }

  Widget _boolSetting(BuildContext context, {
    required String name,
    required bool value,
    void Function()? onToggle,
  }) {
    return TapContainer(
      backgroundColor: Colors.transparent,
      onTap: onToggle,
      padding: EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          Icon(value
              ? context.icons.checkboxSelected
              : context.icons.checkboxEmpty),
        ],
      ),
    );
  }
}
