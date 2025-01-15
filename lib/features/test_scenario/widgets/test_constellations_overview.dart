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

  List<DataGridColumn<TestConstellation, dynamic>> _columns(
    BuildContext context,
    TestScenarioState state,
  ) {
    List<DataGridColumn<TestConstellation, Object?>> columns = [];
    for (int i = 0; i < state.permissions.length; i++) {
      String permission = state.permissions[i].permission;
      String shortcut = permissionToShortcut(permission);
      columns.add(DataGridColumn<TestConstellation, bool>(
        name: shortcut,
        tooltip: permission,
        width: (shortcut.length + 1) * 12,
        getCell: (tc) => context.permissionStateIcon(tc.permissions[i].state),
        getValue: (tc) => tc.permissions[i].state == PermissionState.granted,
        headerAlign: TextAlign.center,
      ));
    }
    columns.add(DataGridColumn<TestConstellation, int>(
      name: "# Blocked Endpoints",
      width: 120,
      headerAlign: TextAlign.center,
      getValue: (tc) => tc.blockedIPs.length,
      getCell: (tc) => Optional.tooltip(
        tooltip: tc.blockedEndpoints
                ?.sortedCopy((a, b) => a.compareTo(b))
                .map((e) => e.name)
                .toList()
                .join("\n") ??
            "",
        show: tc.hasBlockedEndpoints,
        child: Text(
          tc.blockedIPs.length.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    ));
    columns.add(DataGridColumn<TestConstellation, String>(
      name: "Name Appendix",
      width: 150,
      headerAlign: TextAlign.left,
      getValue: (tc) => tc.displayNameAppendix,
      getCell: (tc) => _nameAppendixCell(context, state, tc),
    ));
    return columns;
  }

  DataGridActionColumn<TestConstellation> _rowActions(
    BuildContext context,
    TestScenarioState state,
  ) {
    return DataGridActionColumn<TestConstellation>(actions: [
      (tc) => IconButton(
            icon: Icon(context.icons.remove, color: context.colors.negative),
            onPressed: () => context.testScenarioCubit.removeConstellation(tc),
          )
    ]);
  }

  Widget _nameAppendixCell(BuildContext context, TestScenarioState state, TestConstellation tc,){
    return tc.blockedIPs.isEmpty
        ? const SizedBox.shrink()
        : SimpleTextField(
      initialValue: tc.displayNameAppendix,
      validate: (s) => tc.blockedIPs.isEmpty
          ? null
          : s == null || s.isEmpty
          ? "A name must be specified"
          : state.testConstellations.any((c) =>
      tc != c &&
          tc.abbreviation == c.abbreviation &&
          tc.blockedIPs.length == c.blockedIPs.length &&
          c.displayNameAppendix == s)
          ? "The name is already used"
          : null,
      onChanged: (v) async {
        tc.displayNameAppendix = v;
        Future.delayed(const Duration(milliseconds: 500), () {
          if (tc.displayNameAppendix == v && context.mounted) {
            context.testScenarioCubit.storeScenario();
          }
        });
      },
    );
  }
}
