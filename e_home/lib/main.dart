// TODO: Here you input the utility packages
import 'package:flutter/material.dart';

// TODO: Here you import the screens
import 'package:e_home/Screen_Welcome/welcome.dart';

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
        primaryColor: Color.fromRGBO(80, 223, 225, 1.0),
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color.fromRGBO(16, 34, 63, 1.0),

        // Default Font Family
        fontFamily: 'Montserrat',

        // Default Text Theme
        textTheme: TextTheme(
          // Default Titles
          headline1: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          // Default BodyText
          bodyText1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: WelcomePage(),
    );
  }
}
