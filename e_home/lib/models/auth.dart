import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_home/models/user_profile.dart';

class Auth extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  User user;
  UserProfile _userProfile;
  final blankUserDoc = {
    'name': '',
    'phone': '',
    'photoUrl': '',
    'isAtHome': true,
  };

  void setUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }

  bool isProfileBlank() {
    return _userProfile.name == '';
  }

  Future<void> postUserProfile() async {
    await firestoreInstance.collection('users').doc(user.uid).update({
      'name': _userProfile.name,
      'phone': _userProfile.phone,
      'photoUrl': _userProfile.photoUrl,
    });
  }

  Future<void> signUpWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      // Initialize user's document on Firestore
      firestoreInstance
          .collection('users')
          .doc(user.uid)
          .set(this.blankUserDoc);

      // Initialize user profile
      _userProfile.setProfile(
        name: '',
        phone: '',
        photoUrl: '',
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      // Fetch data from Firestore to userProfile
      final value =
          await firestoreInstance.collection('users').doc(user.uid).get();
      _userProfile.setProfile(
        name: value.data()['name'].toString(),
        phone: value.data()['phone'].toString(),
        photoUrl: value.data()['photoUrl'].toString(),
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
