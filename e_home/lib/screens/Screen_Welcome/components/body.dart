import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/rounded_input_field.dart';
import 'package:e_home/screens/shared_components/rounded_password_field.dart';
import 'package:e_home/screens/shared_components/rounded_button.dart';
import 'package:e_home/screens/shared_components/already_have_account_check.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'background.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_home/presentation/bloc/auth/auth_cubit.dart';
import 'package:e_home/presentation/bloc/login/login_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loginfail = false;
  bool _showpassword = false;
  String email;
  String password;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool isLoginPage = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ******
  /// Controller methods
  /// ******


  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingWidget();
        }
        return _bodyWidget();
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        else{
          _loginfail = true;
        }
      },
    );
  }



  Widget _fromWidget() {
    return Column(

      children: [
        if (isLoginPage == true) Text("", style: TextStyle(fontSize: 0),) else Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _nameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "User Name",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              prefixIcon: Icon(Icons.person_outline,color: Colors.white,),
            ),
          ),
        ),
        isLoginPage == true
            ? Text("", style: TextStyle(fontSize: 0),)
            : SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Email Address",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              prefixIcon: Icon(Icons.email_rounded,color: Colors.white,),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _passwordController,
            style: TextStyle(color: Colors.white),
            obscureText: !_showpassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              prefixIcon: Icon(Icons.lock_outline,color: Colors.white,),
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _showpassword = !_showpassword;
                  });
                },
                child: Icon(
                  _showpassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
         _loginfail ? Text("Incorrect email or password",style: TextStyle(fontSize: 15, color: Colors.red,),):Text("", style: TextStyle(fontSize: 0),),
      ],
    );
  }

  Widget _bodyWidget() {
    Size size = MediaQuery.of(context).size;
    return Background(
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
          _fromWidget(),
          SizedBox(
            height: 15,
          ),
          _buttonWidget(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _rowTextWidget(),
          ),

        ],
      ),
    );
  }

  Widget _loadingWidget(){
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 35, 50, 1.0),
      body: Center(
        child: SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
            );
          },
        )
        ),
      )
    ;
  }
  Widget _buttonWidget() {
    return InkWell(
      onTap: () {
        if (isLoginPage == true) {
          _submitLogin();
        } else {
          _submitRegistration();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .cardColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          isLoginPage == true ? "LOGIN" : "REGISTER",
          style: TextStyle(fontSize: 18, color: Theme
              .of(context)
              .accentColor),
        ),
      ),
    );
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginPage == true ? "Don't have account?" : "Have an account?",
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (isLoginPage == true)
                isLoginPage = false;
              else
                isLoginPage = true;
            });
          },
          child: Text(
            isLoginPage == true ? " Sign Up" : " Sign In",
            style: TextStyle(fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _submitLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _submitRegistration() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitRegistration(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );
    }
  }
}