import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/widgets.dart';

class TrafficDistributionChart extends StatefulWidget {
  const TrafficDistributionChart({required this.connection, super.key});

  final INetworkConnection connection;

  @override
  State<StatefulWidget> createState() => TrafficDistributionChartState();
}

class TrafficDistributionChartState extends State<TrafficDistributionChart> {
  int touchedIndex = -1;
  bool canShowColors = true;
  late List<AnalysisTrafficGroupCubit> trafficGroups;
  late bool loadInPackets;
  late int totalTrafficLoad;
  late Map<AnalysisTrafficGroupCubit, int> loadByGroup;

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
    trafficGroups = state.visibleGroups;
    if (trafficGroups.length > trafficGroupColors.length) {
      // do not have enough colors for all groups (TODO: show bar chart?)
      canShowColors = false;
    }
    loadInPackets = state.trafficLoadInPackets;
    List<NetworkConnection> connections = TrafficAnalyzer.flattenConnections([widget.connection]);
    loadByGroup = TrafficAnalyzer.getTrafficLoadByGroup(
      trafficGroups,
      connections,
      loadInPackets,
    );
    totalTrafficLoad = TrafficAnalyzer.getTrafficLoad(
      connections,
      inPackets: loadInPackets,
    );
  }

  Widget _buildChart(BuildContext context) {
    if(!canShowColors) return Text("Not enough colors to represent all Traffic Groups");
    return Column(
      children: [
        Text("Traffic Distribution", style: context.textTheme.headlineMedium?.copyWith(color: context.colors.onBackground),),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _getPieChart(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getLegendEntries(trafficGroups).insertBetweenItems(
                  () => Margin.vertical(context.constants.smallSpacing)),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _getLegendEntries(List<AnalysisTrafficGroupCubit> groups) {
    assert(groups.length <= trafficGroupColors.length);
    List<LegendEntry> entries = [];
    for (int i = 0; i < groups.length; i++) {
      var group = groups[i];
      entries.add(LegendEntry(
          color: trafficGroupColors[i], text: group.fullName, isSquare: false, size: 14,));
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
    return List.generate(trafficGroups.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 65.0 : 55.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];
      AnalysisTrafficGroupCubit group = trafficGroups[i];
      Color color = trafficGroupColors[i];
      double trafficShare = (loadByGroup[group]??0) / totalTrafficLoad;
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
