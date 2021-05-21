import 'package:e_home/screens/shared_components/services.dart';
import 'package:flutter/material.dart';
import 'background.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:e_home/models/Device.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool switch_state = false;
  Future<Device> _futureDevice;

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          Container(
            height: size.width * 0.25,
            width: size.width * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5.0,
                ),
                IconCoin(
                  height: size.height * 0.06,
                  width: size.height * 0.06,
                  backgroundColor: Colors.yellow.withOpacity(0.1),
                  borderRadius: 10.0,
                  child: Icon(
                    Icons.lightbulb,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                FirebaseServices(),
              ],
            ),
          ),
          Center(
            child: Switch(
              value: switch_state,
              onChanged: (bool s) {
                setState(() {
                  switch_state = s;
                  if (switch_state) {
                    _futureDevice = sendData("test5", "ON");
                  } else {
                    _futureDevice = sendData("test5", "OFF");
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<Device> sendData(String name, String value) async {
  // var url = Uri.parse('localhost:5000/publisher/khang');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  String apiUrl = "http://10.0.2.2:5000/publisher/khang";

  final json = {
    "name": name,
    "value": value,
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
    return Device.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 response,
    // then throw an exception.
    print(response.statusCode);
  }
}
