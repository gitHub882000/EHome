import 'package:flutter/material.dart';
import 'package:e_home/shared_components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData suffixIcon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    @required this.hintText,
    this.icon,
    this.suffixIcon,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon ?? null,
            color: Colors.black,
          ),
          suffixIcon: Icon(
            suffixIcon ?? null,
            color: Colors.black,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
