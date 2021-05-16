import 'package:e_home/screens/Screen_Statistics/statistics_scr.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/image.dart';
import 'background.dart';
import 'current_temp.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';

// Import models
import 'package:e_home/models/Room.dart';
import 'package:e_home/models/TodayDate.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    var dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return Background(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.025,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              children: [
                Text(
                  /*roomsData[index].name,*/
                  'Bedroom',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: size.height * 0.064,
                      ),
                ),
                Spacer(),
                ResidentAvt(
                  image: 'assets/images/Homepage/tham_avt.jpeg',
                  radius: size.height * 0.03,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            '32°C',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text("TodayDate.now"),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          SizedBox(
            height: size.height * 0.015,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatisticsPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
