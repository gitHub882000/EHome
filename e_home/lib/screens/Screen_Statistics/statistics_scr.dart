import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';
import 'package:e_home/screens/shared_components/home_app_bar.dart';
import 'components/body.dart';

class StatisticsPage extends StatelessWidget {
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
    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: HomeAppBar(
        title: 'Weekly Statistics',
        onPressed: _handleBackClick,
      ),
      body: Body(),
    );
  }
}
