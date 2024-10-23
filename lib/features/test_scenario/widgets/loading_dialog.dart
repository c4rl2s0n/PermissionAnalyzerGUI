import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/test_scenario/logic/test_scenario_cubit.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog(this.testScenarioCubit, {this.title, super.key});

  final String? title;
  final TestScenarioCubit testScenarioCubit;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title ?? "Loading",
      expand: false,
      content: BlocProvider.value(
        value: testScenarioCubit,
        child: BlocListener<TestScenarioCubit, TestScenarioState>(
          listenWhen: (oldState, state) => oldState.loading != state.loading,
          listener: (context, state) =>
          !state.loading ? context.navigator.pop() : null,
          child: BlocBuilder<TestScenarioCubit, TestScenarioState>(
            buildWhen: (oldState, state) => oldState.loadingInfo != state.loadingInfo,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  Margin.vertical(context.constants.spacing),
                  if(state.loadingInfo.isNotEmpty)...[Text(state.loadingInfo)],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
