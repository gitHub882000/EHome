import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'background.dart';
import 'roomcard_list.dart';
import 'package:e_home/models/realtime_sensors.dart';

/// This class is used to support saving realtime data history
class RtDataCell {
  double data;
  DateTime date;

  RtDataCell(this.data, this.date);

  RtDataCell.withData(this.data);
}

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Body({
    Key key,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RealtimeSensors _realtimeSensors = RealtimeSensors();
  Map<double, String> i2sMap;
  Map<String, double> s2iMap;
  Map<String, List<RtDataCell>> dataHistory = {
    'LIGHT': [],
    'TEMP': [],
    'HUMID': [],
    'SOUND': [],
  };

  // List<RtDataCell> lightDataHistory = [];
  // List<RtDataCell> tempDataHistory = [];
  // List<RtDataCell> humidDataHistory = [];
  // List<RtDataCell> soundDataHistory = [];
  int lcDisplayLimit = 7;

  /// ******
  /// Utility methods
  /// ******
  @override
  void initState() {
    i2sMap = _realtimeSensors.intToStrDictionary;
    s2iMap = _realtimeSensors.strToIntDictionary;
    super.initState();
  }

  @override
  void dispose() {
    _realtimeSensors.dispose();
    super.dispose();
  }

  /// ******
  /// Controller methods
  /// ******
  void handleDrawerClick() {
    widget.scaffoldKey.currentState.openEndDrawer();
  }

  void handleRoomClick(BuildContext context) {
    Navigator.pushNamed(context, '/roompage-screen');
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    final Widget _circularProgressIndicator = Center(
      child: Container(
        height: size.height * 0.1,
        width: size.height * 0.1,
        child: CircularProgressIndicator(
          strokeWidth: 8,
        ),
      ),
    );

    return Background(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              children: [
                Text(
                  'EHome',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: size.height * 0.06,
                      ),
                ),
                Spacer(),
                Container(
                  height: size.height * 0.058,
                  width: size.height * 0.058,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: size.height * 0.03,
                    icon: Icon(
                      Icons.menu_open,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: handleDrawerClick,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            width: size.width - 20.0,
            height: size.height * 0.3,
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: StreamBuilder(
              stream: _realtimeSensors.listenToSensors(),
              builder: (context, realtimeMap) {
                if (realtimeMap.connectionState == ConnectionState.waiting)
                  return _circularProgressIndicator;
                if (!_realtimeSensors.isInit) {
                  DateTime now = DateTime.now();
                  dataHistory.forEach(
                    (key, value) {
                      value.add(RtDataCell(realtimeMap.data[key], now));
                    },
                  );
                  // lightDataHistory
                  //     .add(RtDataCell(realtimeMap.data['LIGHT'], now));
                  // tempDataHistory
                  //     .add(RtDataCell(realtimeMap.data['TEMP'], now));
                  // humidDataHistory
                  //     .add(RtDataCell(realtimeMap.data['HUMID'], now));
                  // soundDataHistory
                  //     .add(RtDataCell(realtimeMap.data['SOUND'], now));
                  _realtimeSensors.isInit = true;
                } else {
                  double changeCode = realtimeMap.data['CHANGED'];
                  if (changeCode ==
                      _realtimeSensors.strToIntDictionary['LIGHT']) {
                    if (lightDataHistory.length == lcDisplayLimit) {
                      lightDataHistory.removeAt(0);
                    }
                    lightDataHistory.add(
                        RtDataCell(realtimeMap.data['LIGHT'], DateTime.now()));
                  } else if (changeCode != s2iMap['TEMP-HUMID']) {
                    var sensorHistory = dataHistory[i2sMap[changeCode]];
                    if (sensorHistory.length == lcDisplayLimit) {
                      sensorHistory.removeAt(0);
                    }
                    DateTime now = DateTime.now();
                    sensorHistory.add(
                        RtDataCell(realtimeMap.data[i2sMap[changeCode]], now));
                  }
                }

                /// This is for calculating max value of y axis
                int maxDataAsInt = lightDataHistory
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
                return LineChart(
                  mainData(size, halfOfMax, maxData, digitConstant.toDouble()),
                );
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoomCardList(
              /* onRoomTap: () => this.handleRoomClick(context), */
              ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextWithPreIcon(
            spaceSize: size.width * 0.015,
            indentSize: 10.0,
            icon: Container(
              width: size.height * 0.03,
              height: size.height * 0.03,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people_alt_sharp,
                size: size.height * 0.025,
                color: Color.fromRGBO(9, 94, 231, 1.0),
              ),
            ),
            text: Text(
              'Resident',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: size.height * 0.022,
                  ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Container(
            height: size.height * 0.06 + 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: ResidentAvt(
                  image: 'assets/images/Homepage/tham_avt.jpeg',
                  radius: size.height * 0.03,
                  isActive: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData(
      Size size, double halfOfMax, double maxData, double digitConstant) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        checkToShowHorizontalLine: (value) => value % digitConstant == 0,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
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
                        .format(lightDataHistory[barSpot.x.toInt()].date),
                    Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: size.height * 0.015,
                        ),
                    children: [
                      TextSpan(
                        text: '\n${lightDataHistory[barSpot.x.toInt()].data}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
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
          color: const Color(0xff37434d),
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
            lightDataHistory.length,
            (index) => FlSpot(index.toDouble(), lightDataHistory[index].data),
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
            show: true,
            colors: [
              Theme.of(context).cardColor,
            ].map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
