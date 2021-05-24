import 'package:e_home/models/Room.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class DevicesView extends StatefulWidget {
  DevicesView(this.room);
  final Room room;
  @override
  _DevicesViewState createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Room _room = widget.room;

    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: /* _room.airConditioners.length */ _room.devices.length,
        itemBuilder: (BuildContext context, int index) {
          // Condition to get right icon for device
          Widget fitIcon() {
            if (_room.devices[index].type == 'Air Conditioner') {
              return Icon(
                Icons.ac_unit,
                size: size.height * 0.04,
                color: Colors.white,
              );
            } else {
              return Icon(
                Icons.lightbulb,
                size: size.height * 0.04,
                color: Colors.white,
              );
            }
          }

          return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(5.0),
              height: size.height * 0.3,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Container(
                        height: size.height * 0.05,
                        width: size.height * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(130, 130, 130, 1.0),
                            borderRadius: BorderRadius.circular(5)),
                        child: fitIcon())),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      /* '${_room.airConditioners[index].name}', */
                      '${_room.devices[index].type}',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: size.height * 0.025,
                          ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    CustomSwitch(
                      /* value: _room.airConditioners[index].isActive, */
                      value: _room.devices[index].isActive,
                      activeColor: Colors.blue[600],
                      onChanged: (value) {
                        setState(() {
                          _room.airConditioners[index].isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ]));
        },
      ),
    );
  }
}
