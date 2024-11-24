import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/logic.dart';

class EndpointOverviewTable extends StatelessWidget {
  const EndpointOverviewTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EndpointAnalysisCubit, EndpointAnalysisState>(
        builder: (context, state) {
      return InfoContainer(
        title: "Endpoint Overview",
        action: _analyzeEndpointsButton(context, state),
        child: DataGrid<TrafficConnection>(
          columns: _columns(context, state),
          data: state.connections,
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

  List<DataGridColumnSetting<TrafficConnection, Object?>> _columns(
    BuildContext context,
    EndpointAnalysisState state,
  ) {
    return [
      DataGridColumnSetting<TrafficConnection, String?>(
        name: "IP",
        width: 120,
        getCell: (c) => Text(c.endpoint?.ip ?? "None"),
        getValue: (c) => c.endpoint?.ip,
      ),
      DataGridColumnSetting<TrafficConnection, int?>(
        name: "Port",
        width: 80,
        getCell: (c) => Text(c.endpoint?.port?.toString() ?? "None"),
        getValue: (c) => c.endpoint?.port,
      ),
      DataGridColumnSetting<TrafficConnection, String>(
        name: "Hostname",
        width: 200,
        getValue: (c) => c.endpoint?.hostname ?? "Unknown",
      ),
      DataGridColumnSetting<TrafficConnection, String?>(
        name: "Protocols",
        width: 200,
        getCell: (c) => Text(c.protocols ?? "Unknown"),
        getValue: (c) => c.protocols,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "# Tests",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.testRunCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Packets In",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Packets Out",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outCount,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Packets Total",
        width: 130,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Packets Avg",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.countAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Bytes In",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.inBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Bytes Out",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.outBytes,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Bytes Total",
        width: 120,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesTotal,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumnSetting<TrafficConnection, int>(
        name: "Bytes Avg",
        width: 110,
        headerAlign: TextAlign.center,
        getValue: (c) => c.bytesAvg.floor(),
        defaultCellTextAlign: TextAlign.center,
      ),
    ];
  }
}
