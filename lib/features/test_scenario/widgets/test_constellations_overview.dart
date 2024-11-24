import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import '../logic/logic.dart';

class TestConstellationsOverview extends StatelessWidget {
  const TestConstellationsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      title: "Test Constellations",
      child: BlocBuilder<TestScenarioCubit, TestScenarioState>(
        buildWhen: (oldState, state) =>
            oldState.permissions != state.permissions ||
            oldState.testConstellations != state.testConstellations,
        builder: (context, state) => DataGrid<TestConstellation>(
          key: UniqueKey(),
          columns: _columns(context, state),
          data: state.testConstellations,
          rowActions: _rowActions(context, state),
          showIndex: true,
        ),
      ),
    );
  }

  List<DataGridColumnSetting<TestConstellation, dynamic>> _columns(
    BuildContext context,
    TestScenarioState state,
  ) {
    List<DataGridColumnSetting<TestConstellation, Object?>> columns = [];
    for (int i = 0; i < state.permissions.length; i++) {
      String permission = state.permissions[i].permission;
      String shortcut =permissionToShortcut(permission);
      columns.add(DataGridColumnSetting<TestConstellation, bool>(
        name: shortcut,
        tooltip: permission,
        width: (shortcut.length+1)*12,
        getCell: (tc) => context.permissionStateIcon(tc.permissions[i].state),
        getValue: (tc) => tc.permissions[i].state == PermissionState.granted,
        headerAlign: TextAlign.center,
      ));
    }
    return columns;
  }

  DataGridActionColumnSetting<TestConstellation> _rowActions(
    BuildContext context,
    TestScenarioState state,
  ) {
    return DataGridActionColumnSetting(actions: [
      (tc) => IconButton(
            icon: Icon(context.icons.remove, color: context.colors.negative),
            onPressed: () => context.testScenarioCubit.removeConstellation(tc),
          )
    ]);
  }
}
