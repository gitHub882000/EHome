import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomStatesView extends StatelessWidget {
  RoomStatesView(this.roomId);
  final String roomId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget checkStatus(double data, String type) {
      TextStyle warning = TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal,
          color: Colors.red[600]);

      if (type == 'Sound') {
        if (data <= 100)
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

      if (type == 'Light') {
        if (data != null)
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

      if (type == 'Temperature') {
        if (data >= 27 && data <= 30)
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
        if (data >= 40 && data <= 60)
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
                                color: Colors.blue[600],
                              ),
                              child: Icon(
                                Icons.volume_up,
                                size: size.height * 0.02,
                                color: Colors.white,
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
                                color: Colors.blue[600],
                              ),
                              child: Icon(
                                Icons.lightbulb,
                                size: size.height * 0.02,
                                color: Colors.white,
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
                                color: Colors.blue[600],
                              ),
                              child: Icon(
                                Icons.device_thermostat,
                                size: size.height * 0.02,
                                color: Colors.white,
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
                                color: Colors.blue[600],
                              ),
                              child: Icon(
                                Icons.opacity,
                                size: size.height * 0.02,
                                color: Colors.white,
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
                        checkStatus(double.parse(_soundData), 'Sound'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        checkStatus(double.parse(_lightData), 'Light'),
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
