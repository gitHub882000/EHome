import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:e_home/models/device_history.dart';

// ignore: must_be_immutable
class EnergyLineChart extends StatelessWidget {
  final Size size;
  final DeviceHistory _deviceHistory;

  EnergyLineChart({
    Key key,
    @required this.size,
    @required DeviceHistory deviceHistory,
  })  : _deviceHistory = deviceHistory,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget _circularProgressIndicator = Center(
      child: Container(
        height: size.height * 0.1,
        width: size.height * 0.1,
        child: CircularProgressIndicator(
          strokeWidth: 8,
        ),
      ),
    );

    return StreamBuilder(
      stream: _deviceHistory.listenToDeviceHistory(),
      builder: (context, historyMap) {
        if (historyMap.connectionState == ConnectionState.waiting)
          return _circularProgressIndicator;
        List<DateTime> dateData = List.generate(
          7,
          (index) => historyMap.data['DATE'][index] as DateTime,
        );
        List<double> tempData = List.generate(
          7,
          (index) => historyMap.data['RELAY'][index] as double,
        );
        int realLength = 0;
        for (double x in tempData) {
          if (x < 0) break;
          realLength++;
        }
        /// This is for calculating max value of y axis
        int maxDataAsInt = tempData.reduce(max).toInt();
        int digitConstant = pow(10, maxDataAsInt.toString().length - 1);
        int remainder = maxDataAsInt % digitConstant;
        int quotient = maxDataAsInt ~/ digitConstant;
        double maxData = ((remainder < digitConstant / 2)
                ? digitConstant * (quotient + 1)
                : digitConstant * (quotient + 1.5))
            .toDouble();

        /// This is for drawing grids
        double halfOfMax = maxData % digitConstant == 0
            ? maxData / 2
            : (maxData + digitConstant / 2) / 2;

        return LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              checkToShowHorizontalLine: (value) =>
                  value % digitConstant == 0,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xff2a2747),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color(0xff2a2747),
                  strokeWidth: 1,
                );
              },
            ),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueAccent,
                getTooltipItems: (touchedBarSpots) {
                  return touchedBarSpots
                      .map(
                        (barSpot) => LineTooltipItem(
                          tempData[barSpot.x.toInt()].toStringAsFixed(2),
                          Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: size.height * 0.015,
                              ),
                        ),
                      )
                      .toList();
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) =>
                    Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: size.width * 0.03,
                    ),
                margin: size.width * 0.02,
                getTitles: (value) =>
                    DateFormat('MM-dd').format(dateData[value.toInt()]),
              ),
              leftTitles: SideTitles(
                showTitles: true,
                reservedSize: size.width * 0.05,
                margin: size.width * 0.05,
                getTextStyles: (value) =>
                    Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: size.width * 0.03,
                        ),
                getTitles: (value) {
                  if (value == 0.0) {
                    return '$value';
                  } else if (value == halfOfMax) {
                    return '$value';
                  } else if (value == maxData) {
                    return '$value';
                  } else {
                    return '';
                  }
                },
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff2a2747),
                width: 1,
              ),
            ),
            minX: 0,
            maxX: 6.0,
            minY: 0,
            maxY: maxData,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  realLength,
                  (index) => FlSpot(index.toDouble(), tempData[index]),
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 5,
                    color: Theme.of(context).cardColor,
                    strokeWidth: 1.0,
                    strokeColor: Theme.of(context).accentColor,
                  ),
                ),
                isCurved: false,
                colors: [
                  Theme.of(context).cardColor,
                ],
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
