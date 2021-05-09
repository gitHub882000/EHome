import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'background.dart';
import 'roomcard_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

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
                  'EHome',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Spacer(),
                ResidentAvt(
                  image: 'assets/images/Homepage/tham_avt.jpeg',
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            height: size.height * 0.25,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoomCardList(),
          TextWithPreIcon(
            spaceSize: size.width * 0.015,
            isIndent: false,
          ),
        ],
      ),
    );
  }
}
