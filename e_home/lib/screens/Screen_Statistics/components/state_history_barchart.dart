import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:e_home/models/sensor_history.dart';

class StateHistoryBarChart extends StatelessWidget {
  final Size size;
  final SensorHistory _sensorHistory;
  final String feature;
  final IconData icon;
  final Color iconColor;
  final String _title;
  final String _unit;

  StateHistoryBarChart({
    Key key,
    @required this.size,
    @required SensorHistory sensorHistory,
    @required this.feature,
    @required this.icon,
    @required this.iconColor,
  })  : _sensorHistory = sensorHistory,
        _title = feature == 'LIGHT'
            ? 'Light'
            : feature == 'TEMP'
            ? 'Temperature'
            : feature == 'HUMID'
            ? 'Humidity'
            : 'Sound',
        _unit = feature == 'LIGHT'
            ? '(lx)'
            : feature == 'TEMP'
            ? '(\u2103)'
            : feature == 'HUMID'
            ? '(%)'
            : '(dB)',
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconCoin(
              borderRadius: 5,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.07,
              width: size.width * 0.07,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(
                icon,
                color: iconColor,
                size: size.width * 0.045,
              ),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              _title,
              style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: size.height * 0.03,
                letterSpacing: 3.0,
              ),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              _unit,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: size.height * 0.025,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.016,
        ),
        Flexible(
          child: StreamBuilder(
            stream: _sensorHistory.listenToSensorHistory(),
            builder: (context, historyMap) {
              if (historyMap.connectionState == ConnectionState.waiting)
                return _circularProgressIndicator;

              List<DateTime> dateData = List.generate(
                7,
                    (index) => historyMap.data['DATE'][index] as DateTime,
              );
              List<double> tempData = List.generate(
                7,
                    (index) => historyMap.data[feature][index] as double,
              );

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
              return BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) =>
                    value % digitConstant == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xff2a2747),
                      strokeWidth: 0.8,
                    ),
                  ),
                  maxY: maxData,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipMargin: 8.0,
                      getTooltipItem: (
                          group,
                          groupIndex,
                          rod,
                          rodIndex,
                          ) {
                        return BarTooltipItem(
                          rod.y < maxData ? rod.y.toStringAsFixed(2) : '',
                          Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: size.height * 0.014,
                          ),
                        );
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
                    show: false,
                  ),
                  barGroups: List.generate(
                    7,
                        (index) {
                      double data = tempData[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                              y: data >= 0 ? data : maxData,
                              colors: data >= 0
                              ? [
                              Colors.lightBlueAccent,
                              Colors.greenAccent,
                              ]
                              : [
                              Theme.of(context).primaryColor,
                        ],
                        width: size.width * 0.025,
                      ),
                      ],
                      showingTooltipIndicators: [0],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}