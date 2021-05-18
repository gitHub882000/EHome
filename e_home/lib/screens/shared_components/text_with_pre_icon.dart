import 'package:flutter/material.dart';

class TextWithPreIcon extends StatelessWidget {
  final double spaceSize, indentSize;
  final Widget icon, text;

  const TextWithPreIcon({
    Key key,
    this.spaceSize,
    this.indentSize = 0,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          width: indentSize,
        ),
        icon,
        SizedBox(
          width: spaceSize,
        ),
        text,
      ],
    );
  }
}
