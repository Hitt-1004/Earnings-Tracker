// lib/widgets/earnings_graph.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarningsGraph extends StatelessWidget {
  final List<Map<String, dynamic>> earningsData;
  final Function(String) onNodeTap;

  const EarningsGraph({
    super.key,
    required this.earningsData,
    required this.onNodeTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> estimatedEarningsSpots = [];
    final List<FlSpot> actualEarningsSpots = [];
    final dateFormatter = DateFormat('MM/yyyy'); // Date formatter for x-axis labels

    // Populate FlSpot lists with data from earningsData, handling nulls and converting to double
    for (var earning in earningsData) {
      final dateMilliseconds = DateTime.tryParse(earning['pricedate'] ?? '')?.millisecondsSinceEpoch.toDouble() ?? 0;
      final estimatedEarnings = (earning['estimated_eps'] as num?)?.toDouble() ?? 0.0;
      final actualEarnings = (earning['actual_eps'] as num?)?.toDouble() ?? 0.0;

      estimatedEarningsSpots.add(FlSpot(dateMilliseconds, estimatedEarnings));
      actualEarningsSpots.add(FlSpot(dateMilliseconds, actualEarnings));
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: estimatedEarningsSpots,
            isCurved: true,
            barWidth: 3,
            color: Colors.blue, // Use 'color' for a single color
            dotData: FlDotData(show: true),
          ),
          LineChartBarData(
            spots: actualEarningsSpots,
            isCurved: true,
            barWidth: 3,
            color: Colors.red, // Use 'color' for a single color
            dotData: FlDotData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                value.toStringAsFixed(2),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dateFormatter.format(date),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey, width: 0.5)),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8, // Rounded corners for tooltip
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding around tooltip
            tooltipMargin: 8, // Margin around tooltip
            tooltipHorizontalAlignment: FLHorizontalAlignment.center, // Align tooltip to center
            tooltipHorizontalOffset: 0, // Offset for horizontal alignment
            maxContentWidth: 120, // Maximum width of the tooltip
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final date = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
                return LineTooltipItem(
                  'Date: ${dateFormatter.format(date)}\nEPS: ${spot.y.toStringAsFixed(2)}',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
            fitInsideHorizontally: true, // Fit tooltip inside horizontally
            fitInsideVertically: true, // Fit tooltip inside vertically
            showOnTopOfTheChartBoxArea: true, // Show tooltip on top of the chart
          ),
          handleBuiltInTouches: true,
          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
            if (event.isInterestedForInteractions && touchResponse != null) {
              final spot = touchResponse.lineBarSpots?.first;
              if (spot != null) {
                final date = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt()).toIso8601String();
                onNodeTap(date);
              }
            }
          },
        ),
      ),
    );
  }
}
