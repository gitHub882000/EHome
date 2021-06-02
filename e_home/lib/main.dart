// TODO: Here you input the utility packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_home/presentation/bloc/auth/auth_cubit.dart';

import 'presentation/bloc/communication/communication_cubit.dart';
import 'presentation/bloc/login/login_cubit.dart';
import 'presentation/bloc/user/user_cubit.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(EHome());
}

class EHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<CommunicationCubit>(
          create: (_) => di.sl<CommunicationCubit>(),
        )
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

          // Default Text Theme
          textTheme: TextTheme(
            // Default Titles
            headline1: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white54,
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
        home: BlocBuilder<AuthCubit,AuthState>(
          builder: (context,authState){
            if (authState is Authenticated){
              return HomePage(uid:authState.uid);
            }
            if (authState is UnAuthenticated){
              return WelcomePage();
            }
            return Container();
          },
        ),

        // TODO: Here you input the routes to screens
        // TODO: The route name should follow the format: '/<screen-name>'
        routes: {
          '/welcome-screen': (context) => WelcomePage(),
          '/signup-screen': (context) => SignUpPage(),
          '/homepage-screen': (context) => HomePage(),
          '/chatroom-screen': (context) => ChatroomPage(),
          '/roompage-screen': (context) => RoomPage(),
        },
      ),
    );
  }
}
