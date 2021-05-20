import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  User user;
  final blankUserDoc = {
    'name': '',
    'phone': '',
    'photoUrl': '',
    'isAtHome': true,
  };

  Future<bool> isProfileBlank() {
    firestoreInstance.collection('users').doc(user.uid).get().then((value) {
      if (value.data()['name'] == '')
        return true;
      else
        return false;
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
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
