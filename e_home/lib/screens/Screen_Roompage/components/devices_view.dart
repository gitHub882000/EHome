import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_home/models/Room.dart';
import 'package:e_home/screens/shared_components/services.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:http/http.dart' as http;

// Import models
import 'package:e_home/models/DeviceModel.dart';

class DevicesView extends StatefulWidget {
  DevicesView(this.room);
  final Room room;
  @override
  _DevicesViewState createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  Future<DeviceModel> _deviceModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Room _room = widget.room;

    return SizedBox(
        height: size.height * 0.25,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Room list')
              .doc('PnEjfdlyUw7QYhPoHTmA')
              .collection('devices')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.size,
              itemBuilder: (context, index) {
                // Get current device
                dynamic _device = snapshot.data.docs[index];

                // Get the type of device to choose icon
                Widget fitIcon() {
                  if (_device.get('type') == 'Air Conditioner') {
                    return Icon(
                      Icons.ac_unit,
                      size: size.height * 0.04,
                      color: Colors.white,
                    );
                  } else {
                    return Icon(
                      Icons.lightbulb,
                      size: size.height * 0.04,
                      color: Colors.white,
                    );
                  }
                }

                // Get the state of the current device as boolean
                bool switchState;
                if (_device.get('isActive') == true)
                  switchState = true;
                else
                  switchState = false;

                return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(5.0),
                    height: size.height * 0.3,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                              height: size.height * 0.05,
                              width: size.height * 0.06,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(130, 130, 130, 1.0),
                                  borderRadius: BorderRadius.circular(5)),
                              child: fitIcon())),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            /* '${_room.airConditioners[index].name}', */
                            '${_device.get('name')}',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.023,
                                    ),
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          /* FirebaseServices(), */
                          CustomSwitch(
                            value: switchState,
                            activeColor: Colors.blue[600],
                            onChanged: (value) {
                              setState(() {
                                switchState = value;
                                if (switchState) {
                                  _deviceModel = sendData(
                                      '${_device.get('name')}',
                                      'true',
                                      '${_device.get('type')}');
                                } else {
                                  _deviceModel = sendData(
                                      '${_device.get('name')}',
                                      'false',
                                      '${_device.get('type')}');
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ]));
              },
            );
          },
        ));
  }
}

Future<DeviceModel> sendData(String name, String isActive, String type) async {
  // var url = Uri.parse('localhost:5000/publisher/khang');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  String apiUrl = 'https://ehomee.azurewebsites.net/publisher/khang';

  final json = {'name': name, 'isActive': isActive, 'type': type};
  print(json);
  http.Response response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(json));
  if (response.statusCode == 201) {
    // If the server did return a 201 response,
    // then parse the JSON.
    print(response.body);

    return DeviceModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 response,
    // then throw an exception.
    print(response.statusCode);
  }
}
