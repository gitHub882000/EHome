import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_home/models/user_profile.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    // These are providing models of the project
    final userProfile = Provider.of<UserProfile>(context, listen: false);

    return Form(
      child: Column(
        children: [
          _TextFormField(
            onChanged: (value) {
              userProfile.setName(value);
            },
            size: size,
            labelText: 'Name',
            icon: Icons.account_box,
          ),
          _TextFormField(
            onChanged: (value) {
              userProfile.setPhone(value);
            },
            size: size,
            labelText: 'Phone',
            icon: Icons.phone,
            keyboard: TextInputType.number,
          ),
          _TextFormField(
            onChanged: (value) {
              userProfile.setPhotoUrl(value);
            },
            size: size,
            labelText: 'Photo Url',
            icon: Icons.photo,
          ),
        ],
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  final Size size;
  final String labelText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboard;

  const _TextFormField({
    Key key,
    @required this.size,
    @required this.labelText,
    @required this.icon,
    @required this.onChanged,
    this.keyboard = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this.onChanged,
      keyboardType: this.keyboard,
      autocorrect: false,
      cursorColor: Theme.of(context).accentColor,
      style: TextStyle(
        color: Theme.of(context).accentColor,
      ),
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
            ),
        icon: Icon(
          this.icon,
          color: Theme.of(context).accentColor,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
