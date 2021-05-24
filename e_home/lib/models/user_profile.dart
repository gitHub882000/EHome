import 'package:flutter/cupertino.dart';

class UserProfile extends ChangeNotifier {
  String name = '';
  String phone = '';
  String photoUrl = '';

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  void setPhotoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
    notifyListeners();
  }

  void clearProfile() {
    name = '';
    phone = '';
    photoUrl = '';
    notifyListeners();
  }

  bool isMissingInfo() {
    return name == '' || phone == '' || photoUrl == '';
  }
}
