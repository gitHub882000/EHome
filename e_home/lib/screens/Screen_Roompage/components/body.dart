import 'package:e_home/screens/Screen_Roompage/components/room_states_view.dart';
import 'package:e_home/screens/Screen_Roompage/components/today_states_view.dart';
import 'package:e_home/screens/Screen_Roompage/components/devices_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:flutter/widgets.dart';
import 'background.dart';

// Import models
import 'package:e_home/models/Room.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    //Get today date in expected format
    var date = new DateFormat.yMMMMd('en_US').format(DateTime.now()).toString();
    String finalDate = date.toString();

    //Get data from Homepage
    int key = ModalRoute.of(context).settings.arguments as int;
    Room _room = RoomsModel.roomsData[key];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_room.name}',
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontSize: size.height * 0.04),
        ),
      ),
      body: Column(
        children: [
          TodayStatesView(),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
              child: Text(
                'Room states',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: size.height * 0.025),
                textAlign: TextAlign.left,
              )),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoomStatesView(key),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
              child: Text(
                'Devices',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: size.height * 0.025),
                textAlign: TextAlign.left,
              )),
          DevicesView(_room),
          SizedBox(
            height: size.height * 0.005,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.analytics_outlined),
                iconSize: 40,
                onPressed: () {
                  Navigator.pushNamed(context, '/statistics-screen',
                      arguments: key);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
