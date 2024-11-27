import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/widgets/connection_overview/logic/logic.dart';

class ConnectionOverviewTable extends StatelessWidget {
  const ConnectionOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EndpointAnalysisCubit, EndpointAnalysisState>(
        builder: (context, state) {
      return InfoContainer(
        title: "Connection Overview",
        action: _analyzeEndpointsButton(context, state),
        child: DataGrid<TrafficConnection>(
          columns: _columns(context, state),
          onDataSelected: (entry, index) =>
              context.connectionOverviewCubit.updateSelection(entry),
          data: state.connections,
          initialSelectedEntry:
              context.connectionOverviewCubit.state.selectedConnection,
        ),
      );
    });
  }

  Widget _analyzeEndpointsButton(
    BuildContext context,
    EndpointAnalysisState state,
  ) {
    return state.analyzingEndpoints
        ? const CircularProgressIndicator()
        : IconTextButton(
            text: "Analyze Endpoints",
            icon: Icon(context.icons.test),
            padding: context.constants.infoContainerActionButtonPadding,
            onTap: () => context.endpointAnalysisCubit.analyzeEndpoints(),
          );
  }

  List<DataGridColumn<TrafficConnection, Object?>> _columns(
    BuildContext context,
    EndpointAnalysisState state,
  ) {
    return [
      DataGridColumn<TrafficConnection, String?>(
        name: "IP",
        width: 120,
        getCell: (c) => Text(c.endpoint?.ip ?? "None"),
        getValue: (c) => c.endpoint?.ip,
      ),
      DataGridColumn<TrafficConnection, int?>(
        name: "Port",
        width: 80,
        getCell: (c) => Text(c.endpoint?.port?.toString() ?? "None"),
        getValue: (c) => c.endpoint?.port,
      ),
      DataGridColumn<TrafficConnection, String>(
        name: "Hostname",
        width: 220,
        getValue: (c) => c.endpoint?.hostname ?? "Unknown",
        compare: (a, b) {
          String aString = a as String;
          String bString = b as String;
          var aParts = aString.split(".").reversed.toList();
          var bParts = bString.split(".").reversed.toList();
          for(int i=0; i<min(aParts.length, bParts.length); i++){
            int cmp = aParts[i].compareTo(bParts[i]);
            if(cmp != 0) return cmp;
          }
          return aString.length.compareTo(bString.length);
        }
      ),
      DataGridColumn<TrafficConnection, String?>(
        name: "Protocols",
        width: 200,
        getCell: (c) => Text(c.protocolsString ?? "Unknown"),
        getValue: (c) => c.protocols,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "# Tests",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.testRunCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Packets In",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Packets Out",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Packets Total",
        width: 130,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Packets Avg",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Bytes In",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Bytes Out",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Bytes Total",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<TrafficConnection, int>(
        name: "Bytes Avg",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
    ];
  }
}
