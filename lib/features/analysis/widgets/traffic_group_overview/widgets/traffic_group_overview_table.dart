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
      List<AnalysisTrafficGroupCubit> effectiveGroups = state.enabledGroups.where((g) => state.showTestsInGroupTable || !g.tags.any((t) => t.toLowerCase() == "test")).toList();
      return InfoContainer(
        title: "Group Overview",
        action: _actions(context, state),
        child: DataGrid<AnalysisTrafficGroupCubit>(
          columns: _columns(context, state),
          data: effectiveGroups,
        ),
      );
    });
  }

  Widget _actions(BuildContext context, AnalysisState state){
    return Row(
      children: [
        _loadByPacketsSwitch(context, state),
        const Margin.horizontal(50),
        _showTestsInTable(context, state),
      ],
    );
  }

  Widget _loadByPacketsSwitch(BuildContext context, AnalysisState state){
    return BoolSwitch(textLeft: "Bytes", textRight: "Packets", rightSelected: state.trafficLoadInPackets, onChanged: (loadInPackets) => context.analysisCubit.setTrafficLoadInPackets(loadInPackets),);
  }

  Widget _showTestsInTable(BuildContext context, AnalysisState state) {
    return Row(
      children: [
        const Text("List Tests"),
        Switch(
          value: state.showTestsInGroupTable,
          onChanged: (show) => context.analysisCubit.setShowTestsInGroupTable(show),
        ),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
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
      ..._trafficLoadColumns(state),
    ];
  }

  List<DataGridColumn<AnalysisTrafficGroupCubit, dynamic>> _trafficLoadColumns(AnalysisState state){

    return [
      if(state.trafficLoadInPackets)...[
        // Traffic Load in Packets
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets In",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.inCount),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Out",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.outCount),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Total",
          width: 130,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.countTotal),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Avg (by Test)",
          width: 140,
          headerAlign: TextAlign.center,
          getValue: (g) => (g.state.group.connections.fold(0, (load, con) => load += con.countTotal) / g.state.group.testRuns).floor(),
          defaultCellTextAlign: TextAlign.center,
        ),
      ]else...[
        // Traffic Load in Bytes
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes In",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections.fold(0, (load, con) => load += con.inBytes).readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.inBytes),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Out",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections.fold(0, (load, con) => load += con.outBytes).readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.outBytes),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Total",
          width: 120,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections.fold(0, (load, con) => load += con.bytesTotal).readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections.fold(0, (load, con) => load += con.bytesTotal),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Avg (by Test)",
          width: 150,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            (g.state.group.connections.fold(0, (load, con) => load += con.bytesTotal) / g.state.group.testRuns).floor().readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => (g.state.group.connections.fold(0, (load, con) => load += con.bytesTotal) / g.state.group.testRuns).floor(),
        ),
      ],
    ];

  }
}
