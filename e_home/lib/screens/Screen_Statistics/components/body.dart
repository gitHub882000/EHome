import 'package:e_home/screens/shared_components/icon_coin.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:e_home/icons/water_drop_icons.dart';
import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        children: [
          TextWithPreIcon(
            spaceSize: size.width * 0.015,
            indentSize: 10.0,
            icon: Container(
              width: size.height * 0.03,
              height: size.height * 0.03,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.assignment,
                size: size.height * 0.025,
                color: Color.fromRGBO(9, 94, 231, 1.0),
              ),
            ),
            text: Text(
              'Weekly statistics',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: size.height * 0.022,
                  ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Date',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: size.height * 0.02,
                          ),
                    ),
                  ),
                  DataColumn(
                    label: IconCoin(
                      borderRadius: 5,
                      padding: EdgeInsets.all(3.0),
                      height: size.width * 0.06,
                      width: size.width * 0.06,
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.1),
                      child: Icon(
                        Icons.lightbulb,
                        color: Theme.of(context).accentColor,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: IconCoin(
                      borderRadius: 5,
                      padding: EdgeInsets.all(3.0),
                      height: size.width * 0.06,
                      width: size.width * 0.06,
                      backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                      child: Icon(
                        Icons.thermostat_outlined,
                        color: Theme.of(context).accentColor,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: IconCoin(
                      borderRadius: 5,
                      padding: EdgeInsets.all(3.0),
                      height: size.width * 0.06,
                      width: size.width * 0.06,
                      backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                      child: Icon(
                        Water_drop.water_drop_black_24dp,
                        color: Theme.of(context).accentColor,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: IconCoin(
                      borderRadius: 5,
                      padding: EdgeInsets.all(3.0),
                      height: size.width * 0.06,
                      width: size.width * 0.06,
                      backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                      child: Icon(
                        Icons.surround_sound,
                        color: Theme.of(context).accentColor,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                ],
                rows: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}