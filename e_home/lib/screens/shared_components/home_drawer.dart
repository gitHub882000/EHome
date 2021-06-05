import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';

class HomeDrawer extends StatelessWidget {
  /// ******
  /// Controller methods
  /// ******
  void _handleChatroomClick(BuildContext context) {
    Navigator.pushNamed(context, '/chatroom-screen');
  }

  void _handleLogoutClick(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/welcome-screen');
  }

  /// ******
  /// View method
  /// ******
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

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
                press: () => _handleChatroomClick(context),
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
