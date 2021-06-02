import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Import models
import 'package:e_home/models/DeviceModel.dart';

class DevicesView extends StatefulWidget {
  DevicesView(this.roomId);
  final String roomId;
  @override
  _DevicesViewState createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  //Future<DeviceModel> _deviceModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String _roomId = widget.roomId;

    return SizedBox(
        height: size.height * 0.25,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Tam_feed')
              .doc('bc1EFVcnrsWfJieBsVin')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                /* // Get current device
                dynamic _device = snapshot.data.docs[index];
                String _deviceId = snapshot.data.docs[index].id;

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
                  switchState = false; */

                //Get update string in expected format
                String update = new DateFormat('HH:mm:ss MM-dd-yy')
                    .format(DateTime.now())
                    .toString();

                // Get the state of the current device as boolean
                bool switch_state;
                if (snapshot.data.get('data') == '1')
                  switch_state = true;
                else
                  switch_state = false;

                Future<DeviceModel> _futureDevice;

                return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(5.0),
                    height: size.height * 0.3,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
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
                              child:
                                  //fitIcon()
                                  Icon(
                                Icons.lightbulb,
                                size: size.height * 0.04,
                                color: Colors.white,
                              ))),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            //'${_device.get('name')}',
                            'Light',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: size.height * 0.023,
                                    ),
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          CustomSwitch(
                            value: switch_state,
                            activeColor: Colors.blue[600],
                            onChanged: (bool value) {
                              setState(() {
                                switch_state = value;
                                if (switch_state) {
                                  _futureDevice = sendData('CSE_BBC1', '1',
                                      'RELAY', 'bk-iot-relay', '${update}');
                                } else {
                                  _futureDevice = sendData('CSE_BBC1', '0',
                                      'RELAY', 'bk-iot-relay', '${update}');
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ]));
              },
            );
          },
        ));
  }
}

Future<DeviceModel> sendData(String account, String data, String name,
    String topic, String update) async {
  // var url = Uri.parse('localhost:5000/publisher/khang');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  String apiUrl = "http://10.0.2.2:5000/publisher/Tam";

  final json = {
    'account': account,
    'data': data,
    'name': name,
    'topic': topic,
    'update': update
  };
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
