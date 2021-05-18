import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    @required this.hintText,
    this.icon,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          icon: Icon(
            icon ?? null,
            color: Theme.of(context).accentColor,
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
