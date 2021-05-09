import 'package:flutter/material.dart';

class TextWithPreIcon extends StatelessWidget {
  final double spaceSize;
  final Widget icon, text;
  final bool isIndent;

  const TextWithPreIcon({
    Key key,
    this.spaceSize,
    this.icon,
    this.text,
    this.isIndent = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        if (isIndent)
        SizedBox(
          width: spaceSize,
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
