import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_home/screens/Screen_Homepage/components/CountDevices.dart';

class RoomCardList extends StatelessWidget {
  RoomCardList({this.onRoomTap});

  final Function() onRoomTap;

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height * 0.4,
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Room list').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int index) {
                    // Get current room
                    dynamic _room = snapshot.data.docs[index].data();

                    // Get current room ID
                    String _roomId = snapshot.data.docs[index].id;

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/room-screen',
                            arguments: _roomId);
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
                                '${_room['image']}',
                                height: size.height * 0.19,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_room['name']}',
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
                                          color:
                                              Color.fromRGBO(242, 153, 74, 1.0),
                                        ),
                                        text: CountDevices(_roomId, 'Light')),
                                    TextWithPreIcon(
                                        spaceSize: size.width * 0.015,
                                        indentSize: size.width * 0.015,
                                        icon: Icon(
                                          Icons.ac_unit,
                                          size: size.height * 0.03,
                                          color:
                                              Color.fromRGBO(45, 156, 219, 1.0),
                                        ),
                                        text: CountDevices(
                                            _roomId, 'Air Conditioner')),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
