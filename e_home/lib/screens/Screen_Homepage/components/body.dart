import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/resident_avt.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:flutter/widgets.dart';
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
          SizedBox(
            height: size.height * 0.25,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoomCardList(),
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
}
