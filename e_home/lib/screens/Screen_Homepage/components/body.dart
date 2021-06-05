import 'package:e_home/icons/water_drop_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:flutter/widgets.dart';
import 'background.dart';
import 'roomcard_list.dart';
import 'package:e_home/models/realtime_sensors.dart';
import 'realtime_line_chart.dart';
import 'rt_data_cell.dart';

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
  Map<String, List<RtDataCell>> dataHistory = {
    'LIGHT': [],
    'TEMP': [],
    'HUMID': [],
    'SOUND': [],
  };
  int lcDisplayLimit = 7;
  final _chartRealtimeSensors = [
    RealtimeSensor('LIGHT'),
    RealtimeSensor('TEMP-HUMID'),
    RealtimeSensor('TEMP-HUMID'),
    RealtimeSensor('SOUND')
  ];
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
    Colors.lightBlueAccent,
  ];

  /// ******
  /// Utility methods
  /// ******
  @override
  void dispose() {
    _chartRealtimeSensors.map(
      (element) {
        element.dispose();
      },
    );
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
          TextWithPreIcon(
            spaceSize: size.width * 0.015,
            indentSize: 10.0,
            icon: Container(
              width: size.height * 0.026,
              height: size.height * 0.026,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.stacked_line_chart,
                size: size.height * 0.022,
                color: Color.fromRGBO(9, 94, 231, 1.0),
              ),
            ),
            text: Text(
              'Realtime data since login',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: size.height * 0.022,
                  ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _chartFeatures.length,
                (index) => Container(
                  width: size.width - 20.0,
                  height: size.height * 0.5,
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: RealtimeLineChart(
                    size: size,
                    lcDisplayLimit: lcDisplayLimit,
                    realtimeSensor: _chartRealtimeSensors[index],
                    feature: _chartFeatures[index],
                    icon: _chartIconData[index],
                    iconColor: _chartIconColors[index],
                    dataHistory: dataHistory,
                  ),
                ),
              ),
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
              width: size.height * 0.026,
              height: size.height * 0.026,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people_alt_sharp,
                size: size.height * 0.022,
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
}
