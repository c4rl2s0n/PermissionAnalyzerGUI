import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

class TrafficGroupOverviewTable extends StatelessWidget {
  const TrafficGroupOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
        builder: (context, state) {
      return InfoContainer(
        title: "Group Overview",
        child: DataGrid<AnalysisTrafficGroupCubit>(
          columns: _columns(context, state),
          data: state.enabledGroups,
        ),
      );
    });
  }


  List<DataGridColumn<AnalysisTrafficGroupCubit, Object?>> _columns(
    BuildContext context,
    AnalysisState state,
  ) {
    return [
      DataGridColumn<AnalysisTrafficGroupCubit, String>(
        name: "Name",
        width: 100,
        getValue: (g) => g.name,
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, String>(
        name: "Parent",
        width: 150,
        getValue: (g) => g.path,
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, String>(
        name: "Type",
        width: 100,
        getValue: (g) => g.tags.join(", "),
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, int>(
        name: "# Tests",
        width: 90,
        getValue: (g) => g.testRuns,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, int>(
        name: "min # Endpoints",
        width: 150,
        getValue: (g) => g.endpointCountMin,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, int>(
        name: "max # Endpoints",
        width: 150,
        getValue: (g) => g.endpointCountMax,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<AnalysisTrafficGroupCubit, int>(
        name: "avg # Endpoints",
        width: 150,
        getValue: (g) => g.endpointCountAvg,
        defaultCellTextAlign: TextAlign.center,
      ),
    ];
  }
}
