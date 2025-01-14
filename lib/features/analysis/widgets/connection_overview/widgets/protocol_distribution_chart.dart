import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';

class ProtocolDistributionChart extends StatelessWidget {
  const ProtocolDistributionChart({required this.connection, super.key});

  final INetworkConnection connection;

  @override
  Widget build(BuildContext context) {
    return DistributionChart<String, AnalysisCubit, AnalysisState>(
      title: "Protocol Distribution",
      titleColor: context.colors.onBackground,
      chartLabelColor: Colors.white70,
      colors: trafficGroupColors,
      getDataLabel: (d) => d.replaceAll("sll:ethertype:ip:", ""),
      rebuilder: _builder,
      updateValues: _updateValues,
    );
  }

  BlocBuilder<AnalysisCubit, AnalysisState> _builder(
      Widget Function(BuildContext context, AnalysisState state) builder) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      buildWhen: (oldState, state) => oldState.visibleGroups != state.visibleGroups,
      builder: (context, analysisState) => BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) =>
            oldState.trafficLoadInPackets != state.trafficLoadInPackets,
        builder: (context, configState) => builder(context, analysisState),
      ),
    );
  }

  DistributionValues<String> _updateValues(AnalysisState state) {
    List<String> data = connection.protocols;
    bool loadInPackets = state.config.trafficLoadInPackets;
    List<NetworkConnection> connections =
        TrafficAnalyzer.flattenConnections([connection]);
    Map<String, int> volumeByData = TrafficAnalyzer.getTrafficLoadByProtocol(
      data,
      connections,
      loadInPackets,
    );
    int totalVolume = TrafficAnalyzer.getTrafficLoad(
      connections,
      inPackets: loadInPackets,
    );
    return DistributionValues<String>(
      data: data,
      totalVolume: totalVolume,
      volumeByData: volumeByData,
    );
  }
}
