import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/context_extension.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/timeline_cubit.dart';


class ConnectionLiveChart extends StatefulWidget {
  const ConnectionLiveChart(
    this.timelines, {
    this.time = 0,
    this.trafficLoadInPackets = false,
    super.key,
  });

  final bool trafficLoadInPackets;
  final List<TimelineState> timelines;
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
    for (var tl in widget.timelines) {
      // count frames (x-axis
      int frameCount = tl.data.length;
      if (frameCount > maxX) {
        maxX = frameCount.toDouble();
      }
      // check max traffic load
      for (INetworkConnection? con in tl.data) {
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
    }
  }

  @override
  void didUpdateWidget(ConnectionLiveChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trafficLoadInPackets != widget.trafficLoadInPackets ||
        oldWidget.timelines != widget.timelines) {
      _getMaxBounds();
      setState(() {});
    }
    if (oldWidget.time != widget.time) {
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
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: _lineChart()),
              ],
            ),
          ),
          // SizedBox(
          //   height: 50,
          //   child: _legend(),
          // ),
        ],
      ),
    );
  }
  Widget _legend(){
    return Align(
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.timelines.map<Widget>((tl) => Row(
                children: [
                  Icon(
                    context.icons.mapMarker,
                    color: tl.color,
                  ),
                  Margin.horizontal(context.constants.smallSpacing),
                  Text("${tl.test.name}: ${tl.name}")
                ],
              )).toList().insertBetweenItems(() => Margin.horizontal(context.constants.spacing))
            ]),
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
      ExtraLinesData(verticalLines: [VerticalLine(x: widget.time, color: Colors.yellowAccent)]);
  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchCallback: (event, r) {
          if(event is FlTapUpEvent || event is FlPanUpdateEvent){
            TouchLineBarSpot? closeSpot = r?.lineBarSpots?.firstOrNull;
            if(closeSpot == null) return;
            double posInSec = closeSpot.x;
            Duration pos = Duration(milliseconds: (posInSec * 1000).floor());
            context.overviewCubit.seekTo(pos);
          }
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (spots) => spots
              .map((s) => LineTooltipItem(
                  widget.trafficLoadInPackets
                      ? s.y.toString()
                      : s.y.readableFileSize(),
                  context.textTheme.labelSmall ?? const TextStyle()))
              .toList(),
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData {
    return widget.timelines.map((tl) {
      List<INetworkConnection?> cons = tl.data;
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
      return LineChartBarData(spots: spots, color: tl.color);
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
    int interval = maxX <= 60 ? 5 : 10;
    int intVal = value.floor();
    if(intVal % interval == 0) {
      return Text(
        value.toInt().toString(),
        style: style,
      );
    }
    return const SizedBox.shrink();
  }

  SideTitles get leftTitles => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: max((maxY / 5).floorToDouble(), 1),
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
