// TODO: Here you input the utility packages
import 'package:e_home/screens/Screen_Statistics/statistics_scr.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
import 'package:e_home/screens/Screen_Chatroom/chatroom_scr.dart';
import 'package:e_home/screens/Screen_Roompage/roompage_scr.dart';
import 'package:e_home/screens/Screen_Notification/notification_scr.dart';

// TODO: Here you import the models
import 'package:e_home/models/auth.dart';
import 'package:e_home/models/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EHome());
}

class EHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfile>(create: (context) => UserProfile()),
        ChangeNotifierProxyProvider<UserProfile, Auth>(
          create: (context) => Auth(),
          update: (context, userProfile, auth) => auth..setUserProfile(userProfile),
        ),
      ],
      child: MaterialApp(
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
            headline3: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 85,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline4: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
            headline5: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
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

          // Default App Bar Theme
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(33, 35, 50, 1.0),
            centerTitle: true,
            foregroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),

          // Default Dialog Theme
          dialogTheme: DialogTheme(),
        ),

        home: WelcomePage(),

        // TODO: Here you input the routes to screens
        // TODO: The route name should follow the format: '/<screen-name>'
        routes: {
          '/welcome-screen': (context) => WelcomePage(),
          '/signup-screen': (context) => SignUpPage(),
          '/homepage-screen': (context) => HomePage(),
          '/chatroom-screen': (context) => ChatroomPage(),
          '/notification-screen': (context) => NotificationPage(),
          '/room-screen': (context) => RoomPage(),
          '/statistics-screen': (context) => StatisticsPage(),
        },
      ),
    );
  }
}
