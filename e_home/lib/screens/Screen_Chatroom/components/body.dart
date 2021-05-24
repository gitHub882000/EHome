import 'package:flutter/material.dart';
import 'background.dart';
import 'package:e_home/screens/Screen_Chatroom/components/search_bar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          SearchBar(
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
