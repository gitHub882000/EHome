import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:e_home/models/realtime_sensors.dart';
import 'rt_data_cell.dart';

// ignore: must_be_immutable
class RealtimeLineChart extends StatelessWidget {
  final int lcDisplayLimit;
  final Size size;
  final RealtimeSensor _realtimeSensor;
  final String feature;
  final IconData icon;
  final Color iconColor;
  final String _title;
  final String _unit;
  Map<String, List<RtDataCell>> dataHistory;

  RealtimeLineChart({
    Key key,
    @required this.size,
    @required this.lcDisplayLimit,
    @required RealtimeSensor realtimeSensor,
    @required this.feature,
    @required this.icon,
    @required this.iconColor,
    @required this.dataHistory,
  })  : _realtimeSensor = realtimeSensor,
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
              isCircle: true,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.07,
              width: size.width * 0.07,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(
                icon,
                color: iconColor,
                size: size.width * 0.04,
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
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: size.height * 0.025,
                    letterSpacing: 3.0,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.016,
        ),
        Flexible(
          child: StreamBuilder(
            stream: _realtimeSensor.listenToSensors(),
            builder: (context, realtimeMap) {
              if (realtimeMap.connectionState == ConnectionState.waiting)
                return _circularProgressIndicator;
              var sensorHistory = dataHistory[feature];
              if (sensorHistory.length == lcDisplayLimit) {
                sensorHistory.removeAt(0);
              }
              sensorHistory.add(RtDataCell(
                  realtimeMap.data[feature], DateTime.now()));

              /// This is for calculating max value of y axis
              int maxDataAsInt = dataHistory[feature]
                  .reduce(
                    (a, b) => RtDataCell.withData(max(a.data, b.data)),
                  )
                  .data
                  .toInt();
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

              /// This is to get dataList faster
              List<RtDataCell> dataList = dataHistory[feature];

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
                                DateFormat.Hms()
                                    .format(dataList[barSpot.x.toInt()].date),
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: size.height * 0.015,
                                    ),
                                children: [
                                  TextSpan(
                                    text:
                                        '\n${dataList[barSpot.x.toInt()].data}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: size.height * 0.015,
                                        ),
                                  ),
                                ],
                              ),
                            )
                            .toList();
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: false,
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
                  maxX: (lcDisplayLimit - 1).toDouble(),
                  minY: 0,
                  maxY: maxData,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        dataList.length,
                        (index) =>
                            FlSpot(index.toDouble(), dataList[index].data),
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
          ),
        ),
      ],
    );
  }
}
