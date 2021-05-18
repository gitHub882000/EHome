import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onPressed;

  const HomeAppBar({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => this.onPressed(context),
      ),
      title: Text(
        this.title,
        style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
          fontSize: kToolbarHeight * 0.36,
        ),
      ),
    );
  }
}