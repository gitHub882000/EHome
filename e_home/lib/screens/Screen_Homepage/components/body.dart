import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'background.dart';
import 'roomcard_list.dart';
import 'package:e_home/models/realtime_sensors.dart';

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
  List<DateTime> lightTimeHistory = [];
  List<double> lightDataHistory = [];
  List<DateTime> temp_humidTimeHistory = [];
  List<double> tempDataHistory = [];
  List<double> humidDataHistory = [];
  List<DateTime> soundTimeHistory = [];
  List<double> soundDataHistory = [];
  List<double> temp = [0, 1, 2, 3, 4];
  int lcDisplayLimit = 5;

  /// ******
  /// Utility methods
  /// ******
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
                  lightDataHistory.add(realtimeMap.data['LIGHT']);
                  tempDataHistory.add(realtimeMap.data['TEMP']);
                  humidDataHistory.add(realtimeMap.data['HUMID']);
                  soundDataHistory.add(realtimeMap.data['SOUND']);
                  _realtimeSensors.isInit = true;
                } else {
                  if (realtimeMap.data['CHANGED'] ==
                      _realtimeSensors.strToIntDictionary['LIGHT']) {
                    if (lightDataHistory.length == lcDisplayLimit) {
                      lightDataHistory.removeAt(0);
                    }
                    lightDataHistory.add(realtimeMap.data['LIGHT']);
                  }
                }

                /// This is for calculating max value of y axis
                int maxDataAsInt = lightDataHistory.reduce(max).toInt();
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
                  mainData(size, halfOfMax, maxData),
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

  LineChartData mainData(Size size, double halfOfMax, double maxData) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
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
            (index) => FlSpot(index.toDouble(), lightDataHistory[index]),
          ),
          isCurved: false,
          colors: [
            Theme.of(context).cardColor,
            Color(0xff02d39a),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              Theme.of(context).cardColor,
              Color(0xff02d39a),
            ].map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
