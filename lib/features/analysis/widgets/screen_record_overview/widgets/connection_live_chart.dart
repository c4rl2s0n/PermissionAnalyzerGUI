import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class ConnectionLiveChart extends StatefulWidget {
  const ConnectionLiveChart(
    this.connectionTimelines, {
    this.time = 0,
    this.trafficLoadInPackets = false,
    super.key,
  });

  final bool trafficLoadInPackets;
  final Map<String, List<INetworkConnection?>> connectionTimelines;
  final double time;

  @override
  State<ConnectionLiveChart> createState() => _ConnectionLiveChartState();
}

class _ConnectionLiveChartState extends State<ConnectionLiveChart> {
  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;

  double time = 0;

  void _getMaxBounds() {
    for (var key in widget.connectionTimelines.keys) {
      // count frames (x-axis
      int frameCount = widget.connectionTimelines[key]!.length;
      if (frameCount > maxX) {
        maxX = frameCount.toDouble();
      }
      // check max traffic load
      for (INetworkConnection? con in widget.connectionTimelines[key]!) {
        if (con == null) continue;
        if (widget.trafficLoadInPackets) {
          if (con.countTotal > maxY) {
            maxY = con.countTotal.toDouble();
          }
        } else {
          if (con.bytesTotal > maxY) {
            maxY = con.bytesTotal.toDouble();
          }
        }
      }
      // Total is the one with the most data, so should be enough to check the bounds of that
      if (key == "Total") break;
    }
  }

  @override
  void didUpdateWidget(ConnectionLiveChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trafficLoadInPackets != widget.trafficLoadInPackets ||
        oldWidget.connectionTimelines != widget.connectionTimelines) {
      _getMaxBounds();
      setState(() {});
    }
    if(oldWidget.time != widget.time){
      setState(() {
        time = min(widget.time, maxX);
      });
    }
  }

  @override
  void initState() {
    _getMaxBounds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Margin.vertical(context.constants.spacing),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _lineChart(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _lineChart() {
    return LineChart(_data());
  }

  LineChartData _data() {
    return LineChartData(
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsData,
      extraLinesData: extraLines,
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }

  ExtraLinesData get extraLines =>
      ExtraLinesData(verticalLines: [VerticalLine(x: widget.time)]);
  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (spots) => spots
              .map((s) => LineTooltipItem(
                  widget.trafficLoadInPackets
                      ? s.y.toString()
                      : s.y.readableFileSize(),
                  context.textTheme.labelSmall ?? TextStyle()))
              .toList(),
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData {
    return widget.connectionTimelines.keys.map((k) {
      List<INetworkConnection?> cons = widget.connectionTimelines[k]!;
      List<FlSpot> spots = [];
      for (int i = 0; i < cons.length; i++) {
        if (cons[i] == null) {
          spots.add(FlSpot(i.toDouble(), 0));
        } else {
          if (widget.trafficLoadInPackets) {
            spots.add(FlSpot(i.toDouble(), cons[i]!.countTotal.toDouble()));
          } else {
            spots.add(FlSpot(i.toDouble(), cons[i]!.bytesTotal.toDouble()));
          }
        }
      }
      return LineChartBarData(spots: spots);
    }).toList();
  }

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles,
        ),
      );
  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: context.colors.onBackground,
              width: 4), //.withOpacity( 0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    if (value.toInt() % 5 == 0) {
      return Text(
        value.toInt().toString(),
        style: style,
      );
    }
    return SizedBox.shrink();
  }

  SideTitles get leftTitles => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: (maxY / 5).floorToDouble(),
        reservedSize: 70,
      );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget w;
    int val = value.toInt();
    if (widget.trafficLoadInPackets) {
      w = Text(
        val.toString(),
        style: style,
        textAlign: TextAlign.center,
      );
    } else {
      w = Text(
        val.readableFileSize(),
        style: style,
        textAlign: TextAlign.center,
      );
    }
    // else{
    //   w = SizedBox.shrink();
    // }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: w,
    );
  }
}
