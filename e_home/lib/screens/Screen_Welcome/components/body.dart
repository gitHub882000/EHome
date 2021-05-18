import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/rounded_input_field.dart';
import 'package:e_home/screens/shared_components/rounded_password_field.dart';
import 'package:e_home/screens/shared_components/rounded_button.dart';
import 'package:e_home/screens/shared_components/already_have_account_check.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  void _handleLoginClick(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s sign you in.',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: size.height * 0.032,
                          ),
                    ),
                    Text(
                      'Welcome back.\nYou’ve been missed!',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: size.height * 0.032,
                          ),
                    ),
                  ],
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
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  RoundedButton(
                    text: 'SIGN IN',
                    color: Theme.of(context).cardColor,
                    textColor: Theme.of(context).accentColor,
                    press: () {
                      _handleLoginClick(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            AlreadyHaveAccountCheck(
              press: () {
                Navigator.pushReplacementNamed(context, '/signup-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
