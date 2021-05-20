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
                Text(
                  '77',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: size.height * 0.024,
                      ),
                ),
              ],
            ),
          ),
          Center(
            child: Switch(
              value: switch_state,
              onChanged: (bool s)
              {
                setState(() {
                  switch_state = s;
                  print(switch_state);
                  if (switch_state)
                    {
                      _futureDevice = sendData("1", "on");
                    }
                  else
                    {
                      _futureDevice = sendData("1", "off");
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

Future<Device> sendData(String name,String value) async {
  //var url = Uri.parse('https://example.com/whatsit/create');
  //var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'value': value,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 response,
    // then parse the JSON.
    print(response.body);
    return Device.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 response,
    // then throw an exception.
    throw Exception('Failed ');
  }
}