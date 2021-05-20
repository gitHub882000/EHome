import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;

  Future<void> signUpWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      this.userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      this.userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
