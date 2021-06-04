import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String uid;
  HomePage({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Body(
        scaffoldKey: _scaffoldKey,
      ),
      endDrawer: HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/images/Homepage/chatbot_icon.svg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
