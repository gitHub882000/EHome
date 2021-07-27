import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';

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
            if (!snapshot.hasData)
              return const CircularProgressIndicator();
            else {
              // Get the state of the current device as boolean
              String _relayData = snapshot.data.get('data').toString();
              bool stringToBool(String a) => a == '0' ? false : true;
              bool switch_state = stringToBool(_relayData);

              Future<DeviceModel> _futureDevice;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  //Get update string in expected format
                  String update = new DateFormat('HH:mm:ss MM-dd-yy')
                      .format(DateTime.now())
                      .toString();

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
                                    color: Colors.yellowAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.lightbulb,
                                  size: size.height * 0.04,
                                  color: Colors.yellowAccent,
                                ))),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Relay',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontSize: size.height * 0.023,
                                  ),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            Switch(
                              value: switch_state,
                              activeColor: Colors.blue[600],
                              onChanged: (bool val) {
                                setState(() {
                                  switch_state = val;
                                  if (switch_state == true) {
                                    _futureDevice = sendData('CSE_BBC1', '1',
                                        'RELAY', 'bk-iot-relay', update);
                                  } else {
                                    _futureDevice = sendData('CSE_BBC1', '0',
                                        'RELAY', 'bk-iot-relay', update);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ]));
                },
              );
            }
          },
        ));
  }
}

Future<DeviceModel> sendData(String account, String data, String name,
    String topic, String update) async {
  // var url = Uri.parse('localhost:5000/publisher/khang');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  String apiUrl = "https://ehomee.azurewebsites.net/publisher/Tam";
  // String apiUrl = "http://10.0.2.2:5000/publisher/khang";
  final json = {
    'account': account,
    'data': data,
    'name': name,
    'topic': topic,
    'update': update
  };
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
