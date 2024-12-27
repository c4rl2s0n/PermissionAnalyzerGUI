import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/connection_group.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/connection_overview/logic/logic.dart';

class ConnectionOverviewTable extends StatelessWidget {
  const ConnectionOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(builder: (context, state) {
      return InfoContainer(
        title: "Connection Overview",
        action: _actions(context, state),
        child: state.connectionsGrouped
            ? DataGrid<ConnectionGroup>(
                columns: _networkGroupColumns(context, state),
                onDataSelected: (entry, index) =>
                    context.connectionOverviewCubit.updateSelection(entry),
                data: state.connections.whereType<ConnectionGroup>().toList(),
                initialSelectedEntry: null,
                //context.connectionOverviewCubit.state.selectedConnection,
              )
            : DataGrid<NetworkConnection>(
                columns: _networkConnectionColumns(context, state),
                onDataSelected: (entry, index) =>
                    context.connectionOverviewCubit.updateSelection(entry),
                data: state.connections.whereType<NetworkConnection>().toList(),
                initialSelectedEntry: null,
                //context.connectionOverviewCubit.state.selectedConnection,
              ),
      );
    });
  }

  Widget _actions(BuildContext context, AnalysisState state) {
    return Row(
      children: [
        _groupConnectionsSlider(context, state),
        _analyzeEndpointsButton(context, state),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
  }

  Widget _groupConnectionsSlider(BuildContext context, AnalysisState state) {
    return Row(
      children: [
        const Text("Group connections"),
        Switch(
          value: state.connectionsGrouped,
          onChanged: (grouped) => context.analysisCubit.setGrouped(grouped),
        ),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
  }

  Widget _analyzeEndpointsButton(
    BuildContext context,
    AnalysisState state,
  ) {
    return state.analyzingEndpoints
        ? const CircularProgressIndicator()
        : IconTextButton(
            text: "Analyze Endpoints",
            icon: Icon(context.icons.test),
            padding: context.constants.infoContainerActionButtonPadding,
            onTap: () => context.analysisCubit.analyzeEndpoints(),
          );
  }

  List<DataGridColumn<NetworkConnection, Object?>> _networkConnectionColumns(
    BuildContext context,
    AnalysisState state,
  ) {
    return [
      DataGridColumn<NetworkConnection, String>(
        name: "IP",
        width: 120,
        getCell: (c) => Text(c.ip),
        getValue: (c) => c.ip,
      ),
      DataGridColumn<NetworkConnection, int?>(
        name: "Port",
        width: 80,
        getCell: (c) => Text(c.port?.toString() ?? "None"),
        getValue: (c) => c.port,
      ),
      DataGridColumn<NetworkConnection, String>(
          name: "Domain",
          width: 220,
          getValue: (c) => c.endpoint.domain ?? "Unknown",
          compare: (a, b) {
            String aString = a as String;
            String bString = b as String;
            return compareHostnames(aString, bString);
          }),
      DataGridColumn<NetworkConnection, String?>(
        name: "Protocols",
        width: 200,
        getCell: (c) => Text(c.protocolsString),
        getValue: (c) => c.protocolsString,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "# Tests",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.testRunCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Packets In",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Packets Out",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Packets Total",
        width: 130,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Packets Avg",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Bytes In",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Bytes Out",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Bytes Total",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, int>(
        name: "Bytes Avg",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
    ];
  }

  List<DataGridColumn<ConnectionGroup, Object?>> _networkGroupColumns(
    BuildContext context,
    AnalysisState state,
  ) {
    return [
      DataGridColumn<ConnectionGroup, String?>(
        name: "IP Range",
        width: 120,
        getValue: (c) => c.endpoint.ipRange,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "# Endpoints",
        width: 120,
        getValue: (c) => c.endpoint.endpoints.length,
      ),
      DataGridColumn<ConnectionGroup, List<int>>(
        name: "Ports",
        width: 80,
        getCell: (c) => Text(c.ports.join(", ")),
        getValue: (c) => c.ports,
      ),
      DataGridColumn<ConnectionGroup, String>(
          name: "Domain",
          width: 220,
          getValue: (c) => c.endpoint.domain ?? "Unknown",
          compare: (a, b) {
            String aString = a as String;
            String bString = b as String;
            return compareHostnames(aString, bString);
          }),
      DataGridColumn<ConnectionGroup, String?>(
        name: "Protocols",
        width: 200,
        getCell: (c) => Text(c.protocolsString),
        getValue: (c) => c.protocolsString,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "# Tests",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => state.testRunCount(c),
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Packets In",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Packets Out",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Packets Total",
        width: 130,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Packets Avg",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Bytes In",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Bytes Out",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Bytes Total",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<ConnectionGroup, int>(
        name: "Bytes Avg",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
    ];
  }
}
