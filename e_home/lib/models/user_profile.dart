import 'package:flutter/cupertino.dart';

class UserProfile extends ChangeNotifier {
  String name = '';
  String phone = '';
  String photoUrl = '';

  void setProfile(String name, String phone, String photoUrl) {
    this.name = name;
    this.phone = phone;
    this.photoUrl = photoUrl;
  }
}
