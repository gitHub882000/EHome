import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';
import 'package:e_home/screens/shared_components/home_app_bar.dart';
import 'package:e_home/models/Room.dart';
import 'components/body.dart';

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

    //Get data from Homepage
    int key = ModalRoute.of(context).settings.arguments as int;
    Room _room = RoomsModel.roomsData[key];

    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: HomeAppBar(
        title: '${_room.name}',
        onPressed: _handleBackClick,
      ),
      body: Body(),
    );
  }
}
