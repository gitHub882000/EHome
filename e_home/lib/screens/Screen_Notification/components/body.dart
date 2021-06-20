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
  RangeValues _temperatureValues;

  handleAsyn() async {
    String token = await firebase.getToken();
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      "token": token,
    });
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

  updateDataRange(AsyncSnapshot<QuerySnapshot> snapshot, int index, String key,
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
                      setState(() {
                        snapshot.data.docs[index].reference.update({
                          'light': toggle,
                        });
                      });
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
                    value: doc['temperature']['subscribed'],
                    onChanged: (bool toggle) {
                      setState(() {
                        snapshot.data.docs[index].reference.update({
                          'temperature': {
                            'subscribed': toggle,
                            'min': doc['temperature']['min'],
                            'max': doc['temperature']['max'],
                          },
                        });
                      });
                      if (toggle) {
                        firebase.subscribeTopic('TEMP-HUMID');
                      } else {
                        firebase.unsubScribeTopic('TEMP-HUMID');
                      }
                    },
                  ),
                  Visibility(
                    visible: doc['temperature']['subscribed'],
                    child: RangeSlider(
                      values: RangeValues(doc['temperature']['min'].toDouble(),
                          doc['temperature']['max'].toDouble()),
                      min: 0,
                      max: 100,
                      divisions: 101,
                      labels: RangeLabels(doc['temperature']['min'].toString(),
                          doc['temperature']['max'].toString()),
                      onChanged: (RangeValues values) {
                        setState(() {
                          snapshot.data.docs[index].reference.update({
                            'temperature': {
                              'subscribed': doc['temperature']['subscribed'],
                              'min': values.start.round(),
                              'max': values.end.round(),
                            }
                          });
                        });
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text(
                      'Humidity',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: doc['humidity']['subscribed'],
                    onChanged: (bool toggle) {
                      setState(() {
                        snapshot.data.docs[index].reference.update({
                          'humidity': {
                            'subscribed': toggle,
                            'min': doc['humidity']['min'],
                            'max': doc['humidity']['max'],
                          },
                        });
                      });
                      if (toggle) {
                        firebase.subscribeTopic('TEMP-HUMID');
                      } else {
                        firebase.unsubScribeTopic('TEMP-HUMID');
                      }
                    },
                  ),
                  Visibility(
                    visible: doc['humidity']['subscribed'],
                    child: RangeSlider(
                      values: RangeValues(doc['humidity']['min'].toDouble(),
                          doc['humidity']['max'].toDouble()),
                      min: 0,
                      max: 100,
                      divisions: 101,
                      labels: RangeLabels(doc['humidity']['min'].toString(),
                          doc['humidity']['max'].toString()),
                      onChanged: (RangeValues values) {
                        setState(() {
                          snapshot.data.docs[index].reference.update({
                            'humidity': {
                              'subscribed': doc['humidity']['subscribed'],
                              'min': values.start.round(),
                              'max': values.end.round(),
                            }
                          });
                        });
                      },
                    ),
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
