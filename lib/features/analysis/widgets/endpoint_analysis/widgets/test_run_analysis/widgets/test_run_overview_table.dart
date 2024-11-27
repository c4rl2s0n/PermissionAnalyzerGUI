import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/widgets/test_run_analysis/logic/logic.dart';

class TestRunOverviewTable extends StatelessWidget {
  const TestRunOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestRunAnalysisCubit, TestRunAnalysisState>(
      builder: (context, state) => InfoContainer(
        title: "Test Runs",
        child: DataGrid(
          columns: _columns(context),
          data: state.tests,
          onDataSelected: (entry, _) => context.testRunAnalysisCubit.selectTest(entry),
          initialSelectedEntry: state.selectedTest,
        ),
      ),
    );
  }

  List<DataGridColumn<TestRunDto, Object?>> _columns(BuildContext context) {
    return [
      DataGridColumn<TestRunDto, String>(
        name: "Application",
        width: 100,
        getValue: (c) => c.applicationName,
      ),
      DataGridColumn<TestRunDto, String>(
        name: "Scenario",
        width: 100,
        getValue: (c) => c.scenario.name,
      ),
      DataGridColumn<TestRunDto, String>(
        name: "Constellation",
        width: 120,
        getValue: (c) => c.constellation.abbreviation,
      ),
      DataGridColumn<TestRunDto, int>(
        name: "#Testrun",
        width: 100,
        getValue: (c) => c.index,
      ),
      DataGridColumn<TestRunDto, int>(
        name: "# Packets",
        width: 100,
        getValue: (c) => c.test.packets?.length ?? 0,
      ),
      //... TODO ...
      // Add information about the testrun(?)
    ];
  }
}
