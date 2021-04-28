// TODO: Here you input the utility packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: Here you import the screens
import './homepage_f/homepage.dart';

void main() {
  runApp(EHome());
}

class EHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TODO: Here you input the list of EHome's providers (data classes)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(16, 34, 63, 1.0),
          fontFamily: 'Montserrat',
        ),
        home: HomePage(),
      ),
    );
  }
}