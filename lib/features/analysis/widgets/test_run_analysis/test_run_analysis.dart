import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/test_run_analysis/widgets/packet_overview.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/test_run_analysis/widgets/test_run_overview_table.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/test_run_analysis/widgets/test_run_traffic_overview_table.dart';

import 'logic/logic.dart';

class TestRunAnalysis extends StatelessWidget {
  const TestRunAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => TestRunAnalysisCubit(state.tests),
          child: _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    // TODO: List all TestRuns (Application, Scenario, Constellation, #Test)
    // TODO: When Test is selected, list all Endpoints for that run and all the packets (filtered, if endpoint is selected)

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: BlocBuilder<TestRunAnalysisCubit, TestRunAnalysisState>(
            buildWhen: (oldState, state) =>
                oldState.selectedTestIndex != state.selectedTestIndex,
            builder: (context, state) {
              TestRunDto? selectedTest = state.selectedTest;
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 3,
                    child: TestRunOverviewTable(),
                  ),
                  if (selectedTest != null &&
                      selectedTest.test.packets != null) ...[
                    Margin.horizontal(context.constants.spacing),
                    Expanded(
                      flex: 2,
                      child: TestRunTrafficOverviewTable(
                        test: selectedTest.test,
                        packets: selectedTest.test.packets ?? [],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
        BlocBuilder<TestRunAnalysisCubit, TestRunAnalysisState>(
            buildWhen: (oldState, state) =>
                oldState.selectedPacketIndex != state.selectedPacketIndex,
            builder: (context, state) {
              NetworkPacket? packet = state.selectedPacket;
              if(packet == null) return const SizedBox.shrink();
              return Column(
                children: [
                  Margin.vertical(context.constants.spacing),
                  PacketOverview(packet),
                ],
              );
            },
        ),
      ],
    );
  }
}
