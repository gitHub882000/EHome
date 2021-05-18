import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconCoin extends StatelessWidget {
  final bool isCircle;
  final double borderRadius;
  final EdgeInsets padding;
  final double height;
  final double width;
  final Color backgroundColor;
  final Widget child;
  BoxDecoration _boxDecoration;

  IconCoin({
    Key key,
    this.isCircle = false,
    this.borderRadius = 0,
    this.padding = const EdgeInsets.all(0.0),
    @required this.height,
    @required this.width,
    @required this.backgroundColor,
    @required this.child,
  }) : super(key: key) {
    this._boxDecoration = this.isCircle
        ? BoxDecoration(
            color: this.backgroundColor,
            shape: BoxShape.circle,
          )
        : BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(this.borderRadius),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      height: this.height,
      width: this.width,
      decoration: this._boxDecoration,
      child: this.child,
    );
  }
}