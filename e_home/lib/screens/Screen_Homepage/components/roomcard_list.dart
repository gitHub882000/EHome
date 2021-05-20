import 'package:e_home/models/ChoosenRoom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';

import 'package:e_home/models/Room.dart';

class RoomCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height * 0.4,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: RoomsModel.roomsData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  /* WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<ChoosenRoomModel>()
                    .add(RoomsModel.roomsData[index]);
                ChoosenRoomModel arg;
                arg.data = context.read<Room>();
                Iterable<Room> arg = context.read<ChoosenRoomModel>().roomData;
              }); */
                  Navigator.pushNamed(context, '/room-screen',
                      arguments: index);
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5.0),
                  height: size.height * 0.38,
                  width: size.width * 0.52,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          RoomsModel.roomsData[index].image,
                          height: size.height * 0.19,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                RoomsModel.roomsData[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
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
                                  '${RoomsModel.roomsData[index].lightDevices.length} light devices',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
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
                                  '${RoomsModel.roomsData[index].airConditioners.length} air conditioners',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontSize: size.height * 0.022,
                                      ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
