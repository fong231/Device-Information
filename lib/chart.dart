import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    this.xValues = const [],
    this.yValues = const [],
    this.zValues = const [],
  });

  final List<FlSpot> xValues;
  final List<FlSpot> yValues;
  final List<FlSpot> zValues;

  double get minY {
    final all = [...xValues, ...yValues, ...zValues];
    if (all.isEmpty) return -1;

    final minVal = all.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxVal = all.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal).abs();

    final margin = range * 0.2;
    final safeMargin = margin < 0.5 ? 0.5 : margin;

    return minVal - safeMargin;
  }

  double get maxY {
    final all = [...xValues, ...yValues, ...zValues];
    if (all.isEmpty) return 1;

    final minVal = all.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxVal = all.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal).abs();

    final margin = range * 0.2;
    final safeMargin = margin < 0.5 ? 0.5 : margin;

    return maxVal + safeMargin;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false),
        lineBarsData: [
          xValues.isNotEmpty
              ? LineChartBarData(
                  spots: xValues,
                  isCurved: true,
                  color: Colors.red,
                  dotData: FlDotData(show: false),
                )
              : LineChartBarData(spots: []),
          yValues.isNotEmpty
              ? LineChartBarData(
                  spots: yValues,
                  isCurved: true,
                  color: Colors.green,
                  dotData: FlDotData(show: false),
                )
              : LineChartBarData(spots: []),
          zValues.isNotEmpty
              ? LineChartBarData(
                  spots: zValues,
                  isCurved: true,
                  color: Colors.blue,
                  dotData: FlDotData(show: false),
                )
              : LineChartBarData(spots: []),
        ],
      ),
    );
  }
}
