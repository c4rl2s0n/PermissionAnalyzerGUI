import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/widgets.dart';

class ProtocolDistributionChart extends StatefulWidget {
  const ProtocolDistributionChart({required this.connection, super.key});

  final INetworkConnection connection;

  @override
  State<StatefulWidget> createState() => ProtocolDistributionChartState();
}

class ProtocolDistributionChartState extends State<ProtocolDistributionChart> {
  int touchedIndex = -1;
  bool canShowColors = true;
  late List<String> protocols;
  late bool loadInPackets;
  late int totalTrafficLoad;
  late Map<String, int> loadByProtocol;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
        buildWhen: (oldState, state) =>
            oldState.visibleGroups != state.visibleGroups ||
            oldState.trafficLoadInPackets != state.trafficLoadInPackets,
        builder: (context, state) {
          _updateValues(state);
          return _buildChart(context);
        });
  }

  void _updateValues(AnalysisState state) {
    protocols = widget.connection.protocols;
    protocols.sort();
    if (protocols.length > trafficGroupColors.length) {
      // do not have enough colors for all groups (TODO: show bar chart?)
      canShowColors = false;
    }
    loadInPackets = state.trafficLoadInPackets;
    List<NetworkConnection> connections = TrafficAnalyzer.flattenConnections([widget.connection]);
    loadByProtocol = TrafficAnalyzer.getTrafficLoadByProtocol(
      protocols,
      connections,
      loadInPackets,
    );
    totalTrafficLoad = TrafficAnalyzer.getTrafficLoad(
      connections,
      inPackets: loadInPackets,
    );
  }

  Widget _buildChart(BuildContext context) {
    if(!canShowColors) return Text("Not enough colors to represent all protocols");
    return Column(
      children: [
        Text("Protocol Distribution", style: context.textTheme.headlineMedium?.copyWith(color: context.colors.onBackground),),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _getPieChart(),
              ),
            ),
            Margin.horizontal(context.constants.spacing),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getLegendEntries().insertBetweenItems(
                  () => Margin.vertical(context.constants.smallSpacing)),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _getLegendEntries() {
    assert(protocols.length <= trafficGroupColors.length);
    List<LegendEntry> entries = [];
    for (int i = 0; i < protocols.length; i++) {
      var protocol = protocols[i];
      entries.add(LegendEntry(
          color: trafficGroupColors[i], text: protocol.replaceFirst("sll:ethertype:ip:", ""), isSquare: false, size: 14,));
    }
    return entries;
  }

  Widget _getPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 25,
        sections: _pieChartSections(),
      ),
    );
  }

  List<PieChartSectionData> _pieChartSections() {
    return List.generate(protocols.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 65.0 : 55.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];
      String protocol = protocols[i];
      Color color = trafficGroupColors[i];
      double trafficShare = (loadByProtocol[protocol]??0) / totalTrafficLoad;
      return PieChartSectionData(
        color: color,
        value: trafficShare,
        title: '${(trafficShare * 100).toStringAsFixed(2)} %',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
      );
    });
  }
}
