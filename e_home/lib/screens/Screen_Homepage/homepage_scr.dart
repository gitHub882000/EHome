import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
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
