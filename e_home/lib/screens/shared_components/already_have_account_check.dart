import 'package:flutter/material.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool isLogin;
  final Function press;

  const AlreadyHaveAccountCheck({
    Key key,
    this.isLogin = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          isLogin ? 'Don\'t have an account? ' : 'Already have an account? ',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            isLogin ? 'Sign Up' : 'Sign In',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
