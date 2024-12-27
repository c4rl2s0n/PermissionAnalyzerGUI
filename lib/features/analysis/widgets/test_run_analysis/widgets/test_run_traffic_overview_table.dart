import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/test_run_analysis/logic/logic.dart';

class TestRunTrafficOverviewTable extends StatelessWidget {
  const TestRunTrafficOverviewTable({
    required this.test,
    required this.packets,
    super.key,
  });

  final TestRun test;
  final List<NetworkPacket> packets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestRunAnalysisCubit, TestRunAnalysisState>(
      buildWhen: (oldState, state) => oldState.selectedPacketIndex != state.selectedPacketIndex,
      builder: (context, state) {
        return InfoContainer(
          title: "Connection Packets (${packets.length})",
          child: DataGrid<NetworkPacket>(
            columns: _columns(context),
            indexColumnWidth: 48,
            rowHeight: 35,
            initialSelectedEntry: state.selectedPacket,
            onDataSelected: (packet, _) => context.testRunAnalysisCubit.selectPacket(packet),
            data: packets,
          ),
        );
      },
    );
  }

  List<DataGridColumn<NetworkPacket, Object?>> _columns(BuildContext context) {
    bool incoming(NetworkPacket p) => p.ipDst.startsWith("10.0.");
    return [
      DataGridColumn<NetworkPacket, bool>(
        name: "Direction",
        width: 75,
        getValue: (p) => incoming(p),
        getCell: (p) =>
        incoming(p)
            ? Icon(
          context.icons.connectionIn,
          color: context.colors.positive,
        )
            : Icon(
          context.icons.connectionOut,
          color: context.colors.negative,
        ),
      ),
      DataGridColumn<NetworkPacket, double?>(
        name: "Time (s)",
        width: 75,
        getValue: (p) {
          if (p.timeInMs == null) return null;
          return (p.timeInMs! - test.startTimeInMs) / 1000;
        },
      ),
      DataGridColumn<NetworkPacket, String>(
        name: "Protocol",
        width: 115,
        getValue: (p) =>
        p.protocols?.replaceFirst("sll:ethertype:", "") ?? "Unknown",
      ),

      DataGridColumn<NetworkPacket, int>(
        name: "Bytes",
        width: 75,
        getValue: (p) => p.size,
      ),

    ];
  }
}
