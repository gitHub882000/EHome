import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_field_container.dart';

class RoundedInputField extends StatefulWidget {
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
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool _isValid = false;

  /// ******
  /// Controller methods
  /// ******
  bool _isValidEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  void _handleOnTextFieldChanged(String value) {
    widget.onChanged(value);
    if (_isValid != _isValidEmail(value)) {
      setState(() {
        _isValid = _isValidEmail(value);
      });
    }
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextField(
        onChanged: _handleOnTextFieldChanged,
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon ?? null,
            color: Theme.of(context).accentColor,
          ),
          suffixIcon: Tooltip(
            message:
                _isValid ? 'Valid email address' : 'Invalid email address',
            child: Icon(
              _isValid ? Icons.done : Icons.close,
              color: Theme.of(context).accentColor,
            ),
          ),
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
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
