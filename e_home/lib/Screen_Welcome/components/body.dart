import 'package:flutter/material.dart';
import 'package:e_home/shared_components/rounded_input_field.dart';
import 'package:e_home/shared_components/rounded_button.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s sign you in.',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome back.\nYou’ve been missed!',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          RoundedInputField(
            hintText: 'Your Email',
            icon: Icons.person,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: 'Your Password',
            icon: Icons.lock,
            suffixIcon: Icons.visibility,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 15,
          ),
          RoundedButton(
            text: 'Sign In',
            press: () {},
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                color: Theme.of(context).accentColor,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Don\'t have an account? '),
                TextSpan(
                  text: 'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
