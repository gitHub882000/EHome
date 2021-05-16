import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'room_card.dart';

// Import models
import 'package:e_home/models/Room.dart';

class RoomCardList extends StatelessWidget {
  final String image;
  final List<Widget> children;

  const RoomCardList({
    Key key,
    this.image,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roomsData.length,
        itemBuilder: (context, index) => RoomCard(
          image: roomsData[index].image,
          children: [
            Text(
              roomsData[index].name,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.032,
              ),
            ),
            TextWithPreIcon(
              spaceSize: size.width * 0.015,
              indentSize: size.width * 0.015,
              icon: Icon(
                Icons.brightness_5_rounded,
                size: size.height * 0.03,
                color: Color.fromRGBO(242, 153, 74, 1.0),
              ),
              text: Text(
                '${roomsData[index].lightDevices.length} light devices',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: size.height * 0.022,
                ),
              ),
            ),
            TextWithPreIcon(
              spaceSize: size.width * 0.015,
              indentSize: size.width * 0.015,
              icon: Icon(
                Icons.invert_colors,
                size: size.height * 0.03,
                color: Color.fromRGBO(45, 156, 219, 1.0),
              ),
              text: Text(
                '${roomsData[index].airConditioners.length} air conditioners',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: size.height * 0.022,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
