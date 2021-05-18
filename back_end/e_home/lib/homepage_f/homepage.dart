import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const title = Text(
    'EHome',
    textAlign: TextAlign.left,
    style: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontFamily: 'Pacifico',
      fontSize: 50,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
      height: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Row(
                children: [
                  title,
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/no_avt.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
