import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_home/data/model/user_model.dart';
import 'package:e_home/presentation/bloc/auth/auth_cubit.dart';
import 'package:e_home/presentation/bloc/login/login_cubit.dart';
import 'package:e_home/presentation/bloc/user/user_cubit.dart';
import 'package:e_home/screens/Screen_Chatroom/chatroom_scr.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class HomeDrawer extends StatefulWidget {
  final String uid;

  const HomeDrawer({Key key, this.uid}) : super(key: key);
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  /// ******
  /// Controller methods
  /// ******
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }
  void _handleChatroomClick(BuildContext context) {
    Navigator.pushNamed(context, '/chatroom-screen');
  }

  void _handleNotificationClick(BuildContext context) {
    Navigator.pushNamed(context, '/notification-screen');
  }

  void _handleLogoutClick(BuildContext context) async {
    BlocProvider.of<AuthCubit>(context).loggedOut();
    BlocProvider.of<LoginCubit>(context).submitSignOut();
    // Navigator.pushReplacementNamed(context, '/welcome-screen');
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (_, state) {
      if (state is UserLoaded) {
        return build1(context, state);
      }
      return _loadingWidget();
    });
  }


  Widget build1(BuildContext context, UserLoaded users) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = users.users.firstWhere((user) => user.uid == auth.currentUser.uid,
        orElse: () => UserModel());
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: IconCoin(
                  isCircle: true,
                  padding: EdgeInsets.all(5.0),
                  height: double.infinity,
                  width: double.infinity,
                  backgroundColor: Theme.of(context).cardColor.withOpacity(0.1),
                  child: Icon(
                    Icons.home,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
              _DrawerListTile(
                title: 'Profile',
                iconData: Icons.person,
                press: () {},
                size: size,
              ),
              _DrawerListTile(
                title: 'Chatroom',
                iconData: Icons.chat_bubble,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatroomPage(
                        userName: user.name,
                        uid: user.uid,
                      ),
                    ),
                  );
                },
                size: size,
              ),
              _DrawerListTile(
                title: 'Notification',
                iconData: Icons.notifications,
                press: () => _handleNotificationClick(context),
                size: size,
              ),
              _DrawerListTile(
                title: 'Logout',
                iconData: Icons.logout,
                press: () => _handleLogoutClick(context),
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _loadingWidget() {
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
    );
  }
}

/// *************
/// DrawerListTile is only needed to build HomeDrawer
/// *************
class _DrawerListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function() press;
  final Size size;

  const _DrawerListTile({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.press,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        iconData,
        size: size.height * 0.026,
        color: Colors.white54,
      ),
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.headline2.copyWith(
          fontSize: size.height * 0.022,
        ),
      ),
    );
  }
}
