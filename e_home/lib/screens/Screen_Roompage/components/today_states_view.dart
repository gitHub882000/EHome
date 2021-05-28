import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TodayStatesView extends StatelessWidget {
  String checkTime() {
    //Get current time (in Hours)
    String time = new DateFormat("HH").format(DateTime.now()).toString();
    int currentTime = int.parse('${time}');
    if (currentTime >= 0 && currentTime < 12) return 'Morning';
    if (currentTime >= 12 && currentTime < 18)
      return 'Afternoon';
    else
      return 'Evening';
  }

  String checkTimeToChooseImg() {
    if (checkTime() == 'Morning') return 'assets/images/Weather/morning.svg';
    if (checkTime() == 'Afternoon')
      return 'assets/images/Weather/afternoon.svg';
    else
      return 'assets/images/Weather/night.svg';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Get today date in expected format
    var date = new DateFormat.yMMMMd('en_US').format(DateTime.now()).toString();
    String finalDate = date.toString();

    return Container(
        height: size.height * 0.18,
        width: size.width,
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width * 0.8,
              padding: const EdgeInsets.fromLTRB(100.0, 0, 10.0, 0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${checkTime()}, Boss!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: size.height * 0.03),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    '${finalDate}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: size.height * 0.02),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Ho Chi Minh city',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: size.height * 0.02),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                left: 10,
                child: SvgPicture.asset(
                  '${checkTimeToChooseImg()}',
                  height: 130,
                )),
          ],
        ));
  }
}
