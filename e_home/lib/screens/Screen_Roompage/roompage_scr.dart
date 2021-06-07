import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';
import 'package:e_home/screens/shared_components/home_app_bar.dart';
import 'components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomPage extends StatelessWidget {
  /// ******
  /// Controller methods
  /// ******
  void _handleBackClick(BuildContext context) {
    Navigator.pop(context);
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    /* //Get data from Homepage
    String _roomId = ModalRoute.of(context).settings.arguments as String;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('roomList')
            .doc('${_roomId}')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData)
            return const CircularProgressIndicator();
          else {
            dynamic _room = snapshot.data.data();
            return Scaffold(
              endDrawer: HomeDrawer(),
              appBar: HomeAppBar(
                title: '${_room['name']}',
                onPressed: _handleBackClick,
              ),
              body: Body(),
            );
          }
        }); */

    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: HomeAppBar(
        title: 'Living room',
        onPressed: _handleBackClick,
      ),
      body: Body(),
    );
  }
}
