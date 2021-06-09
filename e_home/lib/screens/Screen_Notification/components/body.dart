import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_home/models/auth.dart';
import 'package:e_home/screens/Screen_Notification/components/background.dart';
import 'package:e_home/screens/Screen_Notification/components/firebaseCloudMessaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseNotification firebase = FirebaseNotification();
  CollectionReference ref;
  String uid;

  handleAsyn() async {
    String token = await firebase.getToken();
    print("Firebase token: $token");
  }

  Widget _buildList(DocumentSnapshot snapshot, String room) {
    var s = Map<String, dynamic>.from(snapshot.get(room)).entries.toList();
    return ListView.builder(
      itemCount: s.length,
      itemBuilder: (context, index) {
        String _key = s[index].key;
        bool _value = s[index].value;
        return SwitchListTile(
            title: Text(
              _key,
              style: TextStyle(color: Colors.white),
            ),
            value: _value,
            onChanged: (bool toggle) {
              setState(() {
                _value = toggle;
                if (_value) {
                  firebase.subscribeTopic(_key);
                } else {
                  firebase.unsubScribeTopic(_key);
                }
              });
            });
      },
    );
  }

  updateData(AsyncSnapshot<QuerySnapshot> snapshot, int index, String key,
      bool value) {
    snapshot.data.docs[index].reference.update({
      key: value,
    });
  }

  @override
  void initState() {
    super.initState();
    firebase.initialize();
    uid = FirebaseAuth.instance.currentUser.uid;
    ref = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notification');
    handleAsyn();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: StreamBuilder(
        stream: ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> doc =
                  Map.from(snapshot.data.docs[index].data());
              return Column(
                children: [
                  Text(
                    doc['name'],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SwitchListTile(
                    title: Text(
                      'Light',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: doc['light'],
                    onChanged: (bool toggle) {
                      updateData(snapshot, index, 'light', toggle);
                      if (toggle) {
                        firebase.subscribeTopic('RELAY');
                      } else {
                        firebase.unsubScribeTopic('RELAY');
                      }
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      'Temperature',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: doc['temperature'],
                    onChanged: (bool toggle) {
                      updateData(snapshot, index, 'temperature', toggle);
                      if (toggle) {
                        firebase.subscribeTopic('TEMP-HUMID');
                      } else {
                        firebase.unsubScribeTopic('TEMP-HUMID');
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
