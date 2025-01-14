import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/config_builder.dart';

class TrafficGroupOverviewTable extends StatelessWidget {
  const TrafficGroupOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigBuilder(
        buildWhenAnalysisConfig: (oldState, state) =>
            oldState.showTestsInGroupTable != state.showTestsInGroupTable || oldState.trafficLoadInPackets != state.trafficLoadInPackets,
        builder: (context, analysisState, configState) {
          List<AnalysisTrafficGroupCubit> effectiveGroups = analysisState
              .enabledGroups
              .where((g) =>
                  configState.showTestsInGroupTable ||
                  !g.tags.any((t) => t.toLowerCase() == "test"))
              .toList();
          return InfoContainer(
            title: "Group Overview",
            action: _actions(context, analysisState, configState),
            child: DataGrid<AnalysisTrafficGroupCubit>(
              columns: _columns(context, analysisState),
              data: effectiveGroups,
            ),
          );
        });
  }

  Widget _actions(BuildContext context, AnalysisState state, AnalysisConfigState config) {
    return Row(
      children: [
        _loadByPacketsSwitch(context, config),
        const Margin.horizontal(50),
        _showTestsInTable(context, config),
      ],
    );
  }

  Widget _loadByPacketsSwitch(BuildContext context, AnalysisConfigState config) {
    return BoolSwitch(
      textLeft: "Bytes",
      textRight: "Packets",
      rightSelected: config.trafficLoadInPackets,
      onChanged: (loadInPackets) =>
          context.analysisConfigCubit.setTrafficLoadInPackets(loadInPackets),
    );
  }

  Widget _showTestsInTable(BuildContext context, AnalysisConfigState config) {
    return Row(
      children: [
        const Text("List Tests"),
        Switch(
          value: config.showTestsInGroupTable,
          onChanged: (show) =>
              context.analysisConfigCubit.setShowTestsInGroupTable(show),
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

  List<DataGridColumn<AnalysisTrafficGroupCubit, dynamic>> _trafficLoadColumns(
      AnalysisState state) {
    return [
      if (state.config.trafficLoadInPackets) ...[
        // Traffic Load in Packets
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets In",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.inCount),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Out",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.outCount),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Total",
          width: 130,
          headerAlign: TextAlign.center,
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.countTotal),
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Packets Avg (by Test)",
          width: 140,
          headerAlign: TextAlign.center,
          getValue: (g) => _getAvgValue(
              g.state.group.connections
                  .fold(0, (load, con) => load += con.countTotal),
              g.state.group.testRuns),
          defaultCellTextAlign: TextAlign.center,
        ),
      ] else ...[
        // Traffic Load in Bytes
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes In",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections
                .fold(0, (load, con) => load += con.inBytes)
                .readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.inBytes),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Out",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections
                .fold(0, (load, con) => load += con.outBytes)
                .readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.outBytes),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Total",
          width: 120,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            g.state.group.connections
                .fold(0, (load, con) => load += con.bytesTotal)
                .readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => g.state.group.connections
              .fold(0, (load, con) => load += con.bytesTotal),
        ),
        DataGridColumn<AnalysisTrafficGroupCubit, int>(
          name: "Bytes Avg (by Test)",
          width: 150,
          headerAlign: TextAlign.center,
          getCell: (g) => Text(
            _getAvgValue(
                    g.state.group.connections
                        .fold(0, (load, con) => load += con.bytesTotal),
                    g.state.group.testRuns)
                .readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (g) => _getAvgValue(
              g.state.group.connections
                  .fold(0, (load, con) => load += con.bytesTotal),
              g.state.group.testRuns),
        ),
      ],
    ];
  }

  int _getAvgValue(int sum, int count) {
    if (count == 0) return 0;
    return (sum / count).floor();
  }
}
