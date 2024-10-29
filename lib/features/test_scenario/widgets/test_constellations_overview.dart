import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class TestConstellationsOverview extends StatelessWidget {
  const TestConstellationsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      title: "Test Constellations",
      child: BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) => oldState.permissions != state.permissions ||
            oldState.testConstellations != state.testConstellations,
        builder: (context, state) => DataGrid(
          columns: _columns(state),
          rows: _rows(context, state),
          showIndex: true,
        ),
      ),
    );
  }

  List<DataGridColumnSetting> _columns(TestScenarioState state) {
    return state.permissions
        .map((p) => DataGridColumnSetting(
              name: p.permission
                  .split(".")
                  .last
                  .split("_")
                  .map((p) => p.substring(0, 1))
                  .join(),
              tooltip: p.permission,
      width: 55,
            ))
        .toList();
  }

  List<DataGridRow> _rows(BuildContext context, TestScenarioState state) {
    return state.testConstellations
        .map((c) => DataGridRow(
            cells: c.permissions
                .map((p) => context.permissionStateIcon(p.state))
                .toList()))
        .toList();
  }
}
