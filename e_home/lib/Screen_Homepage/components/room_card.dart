import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String image;
  final Widget child;

  const RoomCard({
    Key key,
    this.image,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.0),
      height: size.height * 0.35,
      width: size.width * 0.55,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              image,
              height: size.height * 0.175,
              fit: BoxFit.fitWidth,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
