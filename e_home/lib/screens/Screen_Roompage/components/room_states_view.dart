import 'package:flutter/material.dart';
import 'package:e_home/screens/shared_components/text_with_pre_icon.dart';
import 'package:e_home/models/Room.dart';

class RoomStatesView extends StatelessWidget {
  RoomStatesView(this._key);
  final int _key;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.26,
        width: size.width * 0.95,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Measure',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextWithPreIcon(
                  spaceSize: size.width * 0.015,
                  indentSize: size.width * 0,
                  icon: Container(
                      height: size.height * 0.025,
                      width: size.height * 0.03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                      ),
                      child: Icon(
                        Icons.volume_up,
                        size: size.height * 0.02,
                        color: Colors.white,
                      )),
                  text: Text(
                    'Sound',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextWithPreIcon(
                  spaceSize: size.width * 0.015,
                  indentSize: size.width * 0,
                  icon: Container(
                      height: size.height * 0.025,
                      width: size.height * 0.03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                      ),
                      child: Icon(
                        Icons.lightbulb,
                        size: size.height * 0.02,
                        color: Colors.white,
                      )),
                  text: Text(
                    'Light',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextWithPreIcon(
                  spaceSize: size.width * 0.015,
                  indentSize: size.width * 0,
                  icon: Container(
                      height: size.height * 0.025,
                      width: size.height * 0.03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                      ),
                      child: Icon(
                        Icons.device_thermostat,
                        size: size.height * 0.02,
                        color: Colors.white,
                      )),
                  text: Text(
                    'Temperature',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextWithPreIcon(
                  spaceSize: size.width * 0.015,
                  indentSize: size.width * 0,
                  icon: Container(
                      height: size.height * 0.025,
                      width: size.height * 0.03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                      ),
                      child: Icon(
                        Icons.opacity,
                        size: size.height * 0.02,
                        color: Colors.white,
                      )),
                  text: Text(
                    'Humidity',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.06,
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Value',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '${RoomsModel.getValueFromSensor('Sound Sensor', _key)} dB',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '${RoomsModel.getValueFromSensor('Light Sensor', _key)} Lux',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '${RoomsModel.getValueFromSensor('Temperature Sensor', _key)}°C',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '${RoomsModel.getValueFromSensor('Humidity Sensor', _key)}%',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.08,
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Status',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Normal',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Normal',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Normal',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Normal',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: size.height * 0.025,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
