import 'package:e_home/screens/Screen_Notification/components/background.dart';
import 'package:e_home/screens/Screen_Notification/components/firebaseCloudMessaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseNotification firebase = FirebaseNotification();

  handleAsyn() async {
    String token = await firebase.getToken();
    print("Firebase token: $token");
  }

  List<bool> bedroomDevice = [true, false, true];
  bool _value = false;

  @override
  void initState() {
    super.initState();
    firebase.initialize();
    handleAsyn();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text("Temperature"),
            selectedTileColor: Colors.white,
            secondary: Icon(Icons.thermostat),
            value: _value,
            onChanged: (bool toggle) {
              setState(() {
                _value = toggle;
                if (_value) {
                  firebase.subscribeTopic('temperature');
                } else {
                  firebase.unsubScribeTopic('temperature');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
