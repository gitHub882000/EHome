import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/rounded_input_field.dart';
import 'package:e_home/screens/shared_components/rounded_password_field.dart';
import 'package:e_home/screens/shared_components/rounded_button.dart';
import 'package:e_home/screens/shared_components/already_have_account_check.dart';
import 'package:e_home/models/auth.dart';
import 'background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _email;
  String _password;
  String _authCode = '';

  /// ******
  /// Controller methods
  /// ******
  void _handleSignupClick(BuildContext context) async {
    Auth _auth = Auth();

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signUpWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.pushReplacementNamed(context, '/homepage-screen');
      } on FirebaseAuthException catch (e) {
        _authCode = e.code == 'email-already-in-use'
            ? 'Email already exists.'
            : e.code == 'weak-password'
                ? 'Password must be more than 5 chars.'
                : e.code == 'unknown'
                    ? 'Authentication information missing.'
                    : e.code;
      }
      setState(() {
        _isLoading = false;
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
                      'Let\'s sign you up.',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: size.height * 0.032,
                          ),
                    ),
                    Text(
                      'Welcome new member!',
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
                    icon: Icons.email_rounded,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  RoundedPasswordField(
                    hintText: 'Your Password',
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      _authCode,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: size.height * 0.018,
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
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
