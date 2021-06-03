import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:e_home/icons/water_drop_icons.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'background.dart';
import 'package:e_home/models/sensor_history.dart';

class Body extends StatefulWidget {
  final _chartFeatures = ['LIGHT', 'TEMP', 'HUMID', 'SOUND'];
  final _chartIconData = [
    Icons.lightbulb,
    Icons.thermostat_outlined,
    Water_drop.water_drop_black_24dp,
    Icons.surround_sound,
  ];
  final _chartIconColors = [
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
  ];

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SensorHistory _sensorHistory = SensorHistory();

  /// ******
  /// Utility methods
  /// ******
  @override
  void dispose() {
    _sensorHistory.dispose();
    super.dispose();
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    // These are constant widgets that will not change
    List<DataColumn> tableAttributes = [
      DataColumn(
        label: Text(
          'Date',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: size.height * 0.02,
              ),
        ),
      ),
      DataColumn(
        label: Row(
          children: [
            IconCoin(
              borderRadius: 5,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.06,
              width: size.width * 0.06,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
              child: Icon(
                Icons.lightbulb,
                color: Theme.of(context).accentColor,
                size: size.width * 0.04,
              ),
            ),
            Text(
              '(lx)',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600, fontSize: size.height * 0.016),
            ),
          ],
        ),
      ),
      DataColumn(
        label: Row(
          children: [
            IconCoin(
              borderRadius: 5,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.06,
              width: size.width * 0.06,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
              child: Icon(
                Icons.thermostat_outlined,
                color: Theme.of(context).accentColor,
                size: size.width * 0.04,
              ),
            ),
            Text(
              '(\u2103)',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600, fontSize: size.height * 0.016),
            ),
          ],
        ),
      ),
      DataColumn(
        label: Row(
          children: [
            IconCoin(
              borderRadius: 5,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.06,
              width: size.width * 0.06,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
              child: Icon(
                Water_drop.water_drop_black_24dp,
                color: Theme.of(context).accentColor,
                size: size.width * 0.04,
              ),
            ),
            Text(
              '(%)',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600, fontSize: size.height * 0.016),
            ),
          ],
        ),
      ),
      DataColumn(
        label: Row(
          children: [
            IconCoin(
              borderRadius: 5,
              padding: EdgeInsets.all(3.0),
              height: size.width * 0.06,
              width: size.width * 0.06,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
              child: Icon(
                Icons.surround_sound,
                color: Theme.of(context).accentColor,
                size: size.width * 0.04,
              ),
            ),
            Text(
              '(dB)',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600, fontSize: size.height * 0.016),
            ),
          ],
        ),
      ),
    ];

    List<DataRow> loadingRow = [
      DataRow(
        cells: [
          DataCell(
            Text(
              'Pending',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          DataCell(
            Text(
              'Pending',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          DataCell(
            Text(
              'Pending',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          DataCell(
            Text(
              'Pending',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          DataCell(
            Text(
              'Pending',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ];

    /// Build widget
    return Background(
      child: Column(
        children: [
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
                Icons.assignment,
                size: size.height * 0.025,
                color: Color.fromRGBO(9, 94, 231, 1.0),
              ),
            ),
            text: Text(
              'Barcharts',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: size.height * 0.022,
                  ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                widget._chartFeatures.length,
                (index) => Container(
                  width: size.width - 20.0,
                  height: size.height * 0.5,
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: StateHistoryBarChart(
                    size: size,
                    sensorHistory: _sensorHistory,
                    feature: widget._chartFeatures[index],
                    icon: widget._chartIconData[index],
                    iconColor: widget._chartIconColors[index],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder(
                  stream: _sensorHistory.listenToSensorHistory(),
                  builder: (context, historyMap) {
                    return DataTable(
                      columns: tableAttributes,
                      rows: historyMap.connectionState ==
                              ConnectionState.waiting
                          ? loadingRow
                          : List.generate(
                              7,
                              (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      DateFormat('MM-dd-yyyy').format(
                                          historyMap.data['DATE'][index]),
                                    ),
                                  ),
                                  DataCell(
                                    historyMap.data['LIGHT'][index] > 0
                                        ? Text(
                                            historyMap.data['LIGHT'][index]
                                                .toStringAsFixed(2),
                                          )
                                        : Text(
                                            'Pending',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                  ),
                                  DataCell(
                                    historyMap.data['TEMP'][index] > 0
                                        ? Text(
                                            historyMap.data['TEMP'][index]
                                                .toStringAsFixed(2),
                                          )
                                        : Text(
                                            'Pending',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                  ),
                                  DataCell(
                                    historyMap.data['HUMID'][index] > 0
                                        ? Text(
                                            historyMap.data['HUMID'][index]
                                                .toStringAsFixed(2),
                                          )
                                        : Text(
                                            'Pending',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                  ),
                                  DataCell(
                                    historyMap.data['SOUND'][index] > 0
                                        ? Text(
                                            historyMap.data['SOUND'][index]
                                                .toStringAsFixed(2),
                                          )
                                        : Text(
                                            'Pending',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                    );
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

class StateHistoryBarChart extends StatelessWidget {
  final Size size;
  final SensorHistory _sensorHistory;
  final String feature;
  final IconData icon;
  final Color iconColor;
  final String _title;
  final String _unit;

  const StateHistoryBarChart({
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
