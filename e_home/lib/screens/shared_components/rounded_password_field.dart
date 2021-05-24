import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_field_container.dart';

// ignore: must_be_immutable
class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextField(
        obscureText: !_isVisible,
        onChanged: widget.onChanged,
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).accentColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Icon(
              _isVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).accentColor,
            ),
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
