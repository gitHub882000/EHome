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
      height: size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _room.airConditioners.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(5.0),
            height: size.height * 0.2,
            width: size.width * 0.35,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${_room.airConditioners[index].name}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: size.height * 0.03,
                      ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                CustomSwitch(
                  value: _room.airConditioners[index].isActive,
                  activeColor: Colors.blue[600],
                  onChanged: (value) {
                    setState(() {
                      _room.airConditioners[index].isActive = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
