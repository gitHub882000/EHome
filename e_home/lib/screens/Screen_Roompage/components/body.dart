import 'package:flutter/material.dart';
import 'background.dart';
import 'package:e_home/screens/shared_components/icon_coin.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          Container(
            height: size.width * 0.25,
            width: size.width * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5.0,
                ),
                IconCoin(
                  height: size.height * 0.06,
                  width: size.height * 0.06,
                  backgroundColor: Colors.yellow.withOpacity(0.1),
                  borderRadius: 10.0,
                  child: Icon(
                    Icons.lightbulb,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '78',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: size.height * 0.024,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
