import 'package:flutter/material.dart';

class ResidentAvt extends StatelessWidget {
  final String image;
  final double radius;
  final bool isActive;

  const ResidentAvt({
    Key key,
    this.image,
    this.radius,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: 2 * radius + 2,
          width: 2 * radius + 2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(image),
          ),
        ),
        if (isActive)
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: Color.fromRGBO(96, 240, 73, 1.0),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
