import 'package:e_home/icons/water_drop_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomStatesView extends StatelessWidget {
  RoomStatesView(this.roomId);
  final String roomId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _uid = FirebaseAuth.instance.currentUser.uid;
    Widget checkStatus(double data, String type) {
      TextStyle warning = TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal,
          color: Colors.red[600]);

      String minTemp, maxTemp, minHumid, maxHumid;
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .collection('notification')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var doc = snapshot.data.docs.first.data() as Map<String, dynamic>;

          minTemp = doc['temperature']['min'].toString();
          maxTemp = doc['temperature']['max'].toString();
          minHumid = doc['humidity']['min'].toString();
          maxHumid = doc['humidity']['max'].toString();

          if (type == 'Temperature') {
            if (data >= double.parse(minTemp) && data <= double.parse(maxTemp))
              return Text(
                'Normal',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: size.height * 0.025),
              );
            return Text(
              'Warning',
              style: warning.copyWith(fontSize: size.height * 0.025),
            );
          }

          if (type == 'Humidity') {
            if (data >= double.parse(minHumid) &&
                data <= double.parse(maxHumid))
              return Text(
                'Normal',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: size.height * 0.025),
              );
            return Text(
              'Warning',
              style: warning.copyWith(fontSize: size.height * 0.025),
            );
          }
        },
      );
    }

    return Container(
        height: size.height * 0.26,
        width: size.width * 0.95,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Tam_feed').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return const CircularProgressIndicator();
              else {
                String _soundData =
                    snapshot.data.docs[0].get('data').toString();
                String _lightData =
                    snapshot.data.docs[2].get('data').toString();
                List<String> _tempAndHumidData =
                    snapshot.data.docs[1].get('data').toString().split("-");
                String _tempData = _tempAndHumidData[0];
                String _humidityData = _tempAndHumidData[1];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Measure',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextWithPreIcon(
                          spaceSize: size.width * 0.015,
                          indentSize: size.width * 0,
                          icon: Container(
                              height: size.height * 0.025,
                              width: size.height * 0.03,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.volume_up,
                                size: size.height * 0.025,
                                color: Colors.lightBlueAccent,
                              )),
                          text: Text(
                            'Sound',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.025,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextWithPreIcon(
                          spaceSize: size.width * 0.015,
                          indentSize: size.width * 0,
                          icon: Container(
                              height: size.height * 0.025,
                              width: size.height * 0.03,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellowAccent.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.lightbulb,
                                size: size.height * 0.025,
                                color: Colors.yellowAccent,
                              )),
                          text: Text(
                            'Light',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.025,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextWithPreIcon(
                          spaceSize: size.width * 0.015,
                          indentSize: size.width * 0,
                          icon: Container(
                              height: size.height * 0.025,
                              width: size.height * 0.03,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.thermostat_outlined,
                                size: size.height * 0.025,
                                color: Colors.orangeAccent,
                              )),
                          text: Text(
                            'Temperature',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.025,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextWithPreIcon(
                          spaceSize: size.width * 0.015,
                          indentSize: size.width * 0,
                          icon: Container(
                              height: size.height * 0.025,
                              width: size.height * 0.03,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.1),
                              ),
                              child: Icon(
                                Water_drop.water_drop_black_24dp,
                                size: size.height * 0.025,
                                color: Colors.blueAccent,
                              )),
                          text: Text(
                            'Humidity',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.025,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.06,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Value',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '${_soundData} dB',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '${_lightData} Lux',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '${_tempData}°C',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '${_humidityData}%',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Status',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: size.height * 0.025,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '-----',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontSize: size.height * 0.025),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          '-----',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontSize: size.height * 0.025),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        checkStatus(double.parse(_tempData), 'Temperature'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        checkStatus(double.parse(_humidityData), 'Humidity'),
                      ],
                    )
                  ],
                );
              }
            }));
  }
}
