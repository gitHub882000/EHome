import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountDevices extends StatelessWidget {
  CountDevices(this.roomId, this.type);
  String roomId;
  String type;

  String checkDeviceType() {
    if (type == 'Air Conditioner')
      return 'Air Conditioners';
    else
      return 'Lights';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('roomList')
          .doc('${roomId}')
          .collection('devices')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int count = 0;
        snapshot.data.docs.forEach((device) {
          if (device.get('name').toString().startsWith('${type}')) count++;
        });
        return Text('${count} ${checkDeviceType()}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: size.height * 0.023));
      },
    );
  }
}
