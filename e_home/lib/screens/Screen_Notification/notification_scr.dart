import 'package:e_home/screens/Screen_Notification/components/body.dart';
import 'package:e_home/screens/shared_components/home_app_bar.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  void _handleClick(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: HomeAppBar(
        title: "Notification Settings",
        onPressed: _handleClick,
      ),
      body: Body(),
    );
  }
}
