

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:e_home/screens/shared_components/home_drawer.dart';
import 'package:e_home/models/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
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
        onPressed: () async {
          await print(auth.currentUser.uid);
        },
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
