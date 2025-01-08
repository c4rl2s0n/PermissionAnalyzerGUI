import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import 'legend_entry.dart';

class DistributionValues<T> {
  DistributionValues({
    required this.data,
    required this.totalVolume,
    required this.volumeByData,
  });
  final List<T> data;
  final int totalVolume;
  final Map<T, int> volumeByData;
}

class DistributionChart<T, X extends StateStreamable<S>, S>
    extends StatefulWidget {
  const DistributionChart({
    this.title,
    this.titleColor = Colors.black,
    this.chartLabelColor = Colors.black,
    this.colors = const [
      Colors.orange,
      Colors.purpleAccent,
      Colors.green,
      Colors.red,
      Colors.blue
    ],
    required this.getDataLabel,
    required this.rebuilder,
    required this.updateValues,
    this.legendEntrySize = 14,
    super.key,
  });

  final String? title;
  final Color titleColor;
  final Color chartLabelColor;
  final List<Color> colors;
  final String Function(T) getDataLabel;
  final BlocBuilder<X, S> Function(Widget Function(BuildContext, S)) rebuilder;
  final DistributionValues<T> Function(S) updateValues;
  final double legendEntrySize;

  @override
  State<DistributionChart<T, X, S>> createState() =>
      _DistributionChartState<T, X, S>();
}

class _DistributionChartState<T, X extends StateStreamable<S>, S>
    extends State<DistributionChart<T, X, S>> {
  int touchedIndex = -1;
  bool canShowColors = true;
  late List<T> data;
  late bool loadInPackets;
  late int totalVolume;
  late Map<T, int> volumeByData;
  List<Color> get _colors => widget.colors;

  double getTrafficShare(T d) => (volumeByData[d] ?? 0) / totalVolume;
  String getTrafficShareString(T d) =>
      '${(getTrafficShare(d) * 100).toStringAsFixed(2)} %';

  @override
  Widget build(BuildContext context) {
    return widget.rebuilder((context, state) {
      _updateValues(state);
      return _buildContent(context);
    });
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        if (widget.title != null && widget.title!.isNotEmpty)
          Text(
            widget.title!,
            style: context.textTheme.headlineMedium
                ?.copyWith(color: widget.titleColor),
          ),
        if (canShowColors) _buildChart(context) else _buildNonChart(context),
      ],
    );
  }

  void _updateValues(S state) {
    var values = widget.updateValues(state);
    data = values.data;
    volumeByData = values.volumeByData;
    totalVolume = values.totalVolume;
    canShowColors = data.length <= _colors.length;
  }

  Widget _buildChart(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildNonChart(BuildContext context) {
    var sortedData =
        data.sortedCopy((a, b) => volumeByData[b]!.compareTo(volumeByData[a]!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedData
          .map(
            (d) => Row(
              children: [
                Text("${widget.getDataLabel(d)}:"),
                const Expanded(child: SizedBox.shrink()),
                Text(getTrafficShareString(d)),
              ],
            ),
          )
          .toList(),
    );
  }

  List<Widget> _getLegendEntries() {
    assert(data.length <= widget.colors.length);
    List<LegendEntry> entries = [];
    for (int i = 0; i < data.length; i++) {
      var dataEntry = data[i];
      entries.add(LegendEntry(
        color: widget.colors[i],
        text: widget.getDataLabel(dataEntry),
        isSquare: false,
        size: widget.legendEntrySize,
      ));
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
              PieChartSectionData? section = pieTouchResponse.touchedSection!.touchedSection;
              if(section == null){
                touchedIndex = -1;
                return;
              }
              touchedIndex = _colors.indexOf(section.color);
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
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 65.0 : 55.0;
      const shadows = [Shadow(color: Colors.black, offset: Offset(2,2), blurRadius: 2)];
      T dataEntry = data[i];
      Color color = widget.colors[i];
      double trafficShare = getTrafficShare(dataEntry);
      return PieChartSectionData(
        color: color,
        value: trafficShare,
        title: '${(trafficShare * 100).toStringAsFixed(2)} %',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: widget.chartLabelColor,
          shadows: shadows,
        ),
      );
    });
  }
}
