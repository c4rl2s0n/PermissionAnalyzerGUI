import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _AppColors{
  static const Color contentColorYellow = Colors.yellow;
  static const Color contentColorGreen = Colors.green;
  static const Color contentColorOrange = Colors.orange;
  static const Color contentColorPink = Colors.pink;
  static const Color contentColorBlue = Colors.blue;
  static const Color contentColorRed = Colors.red;
  static const Color mainTextColor1 = Colors.black;
  static const Color borderColor = Colors.black26;
}

class MyBarChart extends StatefulWidget {
  MyBarChart({super.key});

  final shadowColor = const Color(0xFFCCCCCC);
  final dataList = [
    const _BarData(_AppColors.contentColorYellow, 18, 18),
    const _BarData(_AppColors.contentColorGreen, 17, 8),
    const _BarData(_AppColors.contentColorOrange, 10, 15),
    const _BarData(_AppColors.contentColorPink, 2.5, 5),
    const _BarData(_AppColors.contentColorBlue, 2, 2.5),
    const _BarData(_AppColors.contentColorRed, 2, 2),
  ];

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  BarChartGroupData generateBarGroup(
      int x,
      Color color,
      double value,
      double shadowValue,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              const Text(
                'Horizontal Bar Chart',
                style: TextStyle(
                  color: _AppColors.mainTextColor1,
                  fontSize: 20,
                ),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Tooltip(
                      message: 'Rotate the chart 90 degrees (cw)',
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            rotationTurns += 1;
                          });
                        },
                        icon: RotatedBox(
                          quarterTurns: rotationTurns - 1,
                          child: const Icon(
                            Icons.rotate_90_degrees_cw,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 18),
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                //rotationQuarterTurns: rotationTurns,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: _AppColors.borderColor.withOpacity(0.8),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          //meta: meta,
                          axisSide: AxisSide.left,
                          child: _IconWidget(
                            color: widget.dataList[index].color,
                            isSelected: touchedGroupIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: _AppColors.borderColor.withOpacity(0.8),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: widget.dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                    index,
                    data.color,
                    data.value,
                    data.shadowValue,
                  );
                }).toList(),
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipMargin: 0,
                    getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                        ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rod.color,
                          fontSize: 18,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
          (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}