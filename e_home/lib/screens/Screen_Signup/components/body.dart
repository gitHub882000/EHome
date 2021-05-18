import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/rounded_input_field.dart';
import 'package:e_home/screens/shared_components/rounded_password_field.dart';
import 'package:e_home/screens/shared_components/rounded_button.dart';
import 'package:e_home/screens/shared_components/already_have_account_check.dart';
import 'background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email;
  String password;

  /// ******
  /// Controller methods
  /// ******
  void _handleSignupClick(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/homepage-screen');
    }
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Background(
        child: Column(
          children: [
            Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Welcome new member!',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Montserrat',
                    fontSize: size.height * 0.032,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RoundedInputField(
                    hintText: 'Your Email',
                    icon: Icons.person,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    hintText: 'Your Password',
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedPasswordField(
                    hintText: 'Confirm Password',
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  RoundedButton(
                    text: 'SIGN UP',
                    color: Theme.of(context).cardColor,
                    textColor: Theme.of(context).accentColor,
                    press: () {
                      _handleSignupClick(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            AlreadyHaveAccountCheck(
              isLogin: false,
              press: () {
                Navigator.pushReplacementNamed(context, '/welcome-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
