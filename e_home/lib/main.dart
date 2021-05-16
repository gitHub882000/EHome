// TODO: Here you input the utility packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Note: If you have widgets that are shared among more than 1 screens,
/// put those widget definition files into shared_components directory.
/// Otherwise, put them into the directories whose files need those widgets.
/// Shared components should be imported as packages.
/// Components only relevant to the file should be imported as files.
///
/// The folders containing each screen should be in capitalized format:
/// <Screen_Name>
// TODO: Here you import the screens
import 'package:e_home/screens/Screen_Welcome/welcome_scr.dart';
import 'package:e_home/screens/Screen_Signup/signup_scr.dart';
import 'package:e_home/screens/Screen_Homepage/homepage_scr.dart';

void main() {
  runApp(EHome());
}

class EHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EHome',
      theme: ThemeData(
        // Default Color
        primaryColor: Color.fromRGBO(55, 60, 89, 1.0),
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color.fromRGBO(33, 35, 50, 1.0),
        cardColor: Color.fromRGBO(38, 151, 255, 1.0),

        // Default Font Family
        fontFamily: 'Montserrat',

        // Default Text Theme
        textTheme: TextTheme(
          // Default Titles
          headline1: TextStyle(
            fontFamily: 'Pacifico',
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          // Default BodyText
          bodyText1: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      home: WelcomePage(),

      // TODO: Here you input the routes to screens
      // TODO: The route name should follow the format: '/<screen-name>'
      routes: {
        '/welcome-screen': (context) => WelcomePage(),
        '/signup-screen': (context) => SignUpPage(),
        '/homepage-screen': (context) => HomePage(),
      },
    );
  }
}
