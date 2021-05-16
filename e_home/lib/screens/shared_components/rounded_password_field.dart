import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).accentColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Theme.of(context).accentColor,
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
