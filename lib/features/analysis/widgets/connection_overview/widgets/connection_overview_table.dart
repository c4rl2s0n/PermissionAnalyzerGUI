import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/widgets/factories/context_menu_factory.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/connection_group.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/connection_overview/logic/logic.dart';

class ConnectionOverviewTable extends StatelessWidget {
  const ConnectionOverviewTable({this.initialSelectionIndex, super.key});

  final int? initialSelectionIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionOverviewCubit, ConnectionOverviewState>(
      buildWhen: (oldState, state) => oldState.connections != state.connections,
  builder: (context, state) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
        buildWhen: (oldState, state) => oldState.connectionsGrouped != state.connectionsGrouped
            || oldState.trafficLoadInPackets != state.trafficLoadInPackets
            || oldState.analyzingEndpoints != state.analyzingEndpoints,
        builder: (context, analysisState) {
      return InfoContainer(
        title: "Connection Overview",
        action: _actions(context, analysisState),
        child: analysisState.connectionsGrouped
            ? DataGrid<ConnectionGroup>(
                columns: _networkGroupColumns(context, analysisState),
                onDataSelected: (entry, index) =>
                    context.connectionOverviewCubit.updateSelection(entry),
                onDataSecondaryTap: (entry, [pos]) =>
                    _onDataSecondaryTap(context, entry, pos),
                data: state.connections.whereType<ConnectionGroup>().toList(),
                initialSelectedIndex: initialSelectionIndex,
                //context.connectionOverviewCubit.state.selectedConnection,
              )
            : DataGrid<NetworkConnection>(
                columns: _networkConnectionColumns(context, analysisState),
                onDataSelected: (entry, index) =>
                    context.connectionOverviewCubit.updateSelection(entry),
                onDataSecondaryTap: (entry, [pos]) =>
                    _onDataSecondaryTap(context, entry, pos),
                data: state.connections.whereType<NetworkConnection>().toList(),
                initialSelectedIndex: initialSelectionIndex,
                //context.connectionOverviewCubit.state.selectedConnection,
              ),
      );
    });
  },
);
  }


  void _onDataSecondaryTap(BuildContext context, INetworkConnection connection,
      [Offset? position]) {
    position ??= Offset.zero;
    ContextMenuFactory.showContextMenuOnPosition(context, position, [
      ContextMenuItem(
          name: "Copy Wireshark Filter",
          onTap: (context) async {
            await Clipboard.setData(ClipboardData(text: connection.wiresharkFilter));
            if(context.mounted) {
              context.messenger.showSnackBar(
                SnackBarFactory.getPositiveSnackBar(context,
                    text: "Wireshark filter copied to clipboard."),
              );
            }
          },
          icon: Icon(context.icons.filter))
    ]);
  }

  Widget _actions(BuildContext context, AnalysisState state) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Margin.horizontal(42),
          _loadByPacketsSwitch(context, state),
          _groupConnectionsSlider(context, state),
          _analyzeEndpointsButton(context, state),
        ],
      ),
    );
  }

  Widget _loadByPacketsSwitch(BuildContext context, AnalysisState state){
    return BoolSwitch(textLeft: "Bytes", textRight: "Packets", rightSelected: state.trafficLoadInPackets, onChanged: (loadInPackets) => context.analysisCubit.setTrafficLoadInPackets(loadInPackets),);
  }

  Widget _groupConnectionsSlider(BuildContext context, AnalysisState state) {
    return Row(
      children: [
        const Text("Group connections"),
        Switch(
          value: state.connectionsGrouped,
          onChanged: (grouped) {
              context.connectionOverviewCubit.updateSelection(null);
              context.analysisCubit.setGrouped(grouped);
            },
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
        : GestureDetector(
            onSecondaryTap: () =>
                context.analysisCubit.analyzeEndpoints(force: true),
            child: IconTextButton(
              text: "Analyze Endpoints",
              icon: Icon(context.icons.test),
              padding: context.constants.infoContainerActionButtonPadding,
              onTap: () => context.analysisCubit.analyzeEndpoints(),
            ),
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
          getCell: (c) => Optional.tooltip(
              tooltip: c.endpoint.hostname ?? "",
              show: c.endpoint.hasHostname,
              child: Text(c.endpoint.domain ?? "Unknown")),
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
        getCell: (c) => Tooltip(
            message: c.testRuns.map((t) => t.name).toList().distinct.join("\n"),
            child: Text(
              c.testRunCount.toString(),
              textAlign: TextAlign.center,
            )),
        getValue: (c) => c.testRunCount,
      ),
      DataGridColumn<NetworkConnection, String?>(
        name: "Continent",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.endpoint.geolocations.firstOrNull?.continent,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, String?>(
        name: "Country",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.endpoint.geolocations.firstOrNull?.country,
        defaultCellTextAlign: TextAlign.center,
      ),
      DataGridColumn<NetworkConnection, String?>(
        name: "City",
        width: 100,
        headerAlign: TextAlign.center,
        getValue: (c) => c.endpoint.geolocations.firstOrNull?.city,
        defaultCellTextAlign: TextAlign.center,
      ),
      ..._trafficLoadColumns<NetworkConnection>(context, state),
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
        getCell: (c) => Optional.tooltip(
            tooltip: c.endpoint.endpoints
                .map((e) => e.ip)
                .toList()
                .sorted
                .join("\n"),
            show: c.endpoint.endpoints.length > 1,
            child: Text(c.endpoint.ipRange)),
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
          getCell: (c) => Optional.tooltip(
              tooltip: c.endpoint.endpoints
                  .map((e) => e.hostname)
                  .nonNulls
                  .toList()
                  .sorted
                  .join("\n"),
              show: c.endpoint.hasHostname,
              child: Text(c.endpoint.domain ?? "Unknown")),
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
        getCell: (c) => Tooltip(
            message: c.testRuns.map((t) => t.name).toList().distinct.join("\n"),
            child: Text(
              c.testRunCount.toString(),
              textAlign: TextAlign.center,
            )),
        getValue: (c) => c.testRunCount,
      ),
      ..._trafficLoadColumns<ConnectionGroup>(context, state),
    ];
  }

  List<DataGridColumn<T, Object?>> _trafficLoadColumns<T extends INetworkConnection>(
    BuildContext context,
    AnalysisState state,
  ) {
    return [
      if(state.trafficLoadInPackets)...[
        // Traffic Load in Packets
        DataGridColumn<T, int>(
          name: "Packets In",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (c) => c.inCount,
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<T, int>(
          name: "Packets Out",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (c) => c.outCount,
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<T, int>(
          name: "Packets Total",
          width: 130,
          headerAlign: TextAlign.center,
          getValue: (c) => c.countTotal,
          defaultCellTextAlign: TextAlign.center,
        ),
        DataGridColumn<T, int>(
          name: "Packets Avg",
          width: 120,
          headerAlign: TextAlign.center,
          getValue: (c) => c.countAvg.floor(),
          defaultCellTextAlign: TextAlign.center,
        ),
      ]else...[
        // Traffic Load in Bytes
        DataGridColumn<T, int>(
          name: "Bytes In",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (c) => Text(
            c.inBytes.readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (c) => c.inBytes,
        ),
        DataGridColumn<T, int>(
          name: "Bytes Out",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (c) => Text(
            c.outBytes.readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (c) => c.outBytes,
        ),
        DataGridColumn<T, int>(
          name: "Bytes Total",
          width: 120,
          headerAlign: TextAlign.center,
          getCell: (c) => Text(
            c.bytesTotal.readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (c) => c.bytesTotal,
        ),
        DataGridColumn<T, int>(
          name: "Bytes Avg",
          width: 110,
          headerAlign: TextAlign.center,
          getCell: (c) => Text(
            c.bytesAvg.floor().readableFileSize(base1024: false),
            textAlign: TextAlign.center,
          ),
          getValue: (c) => c.bytesAvg.floor(),
        ),
      ],
    ];
  }
}
