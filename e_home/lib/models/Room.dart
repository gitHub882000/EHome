import 'package:flutter/material.dart';

class RoomsModel {
  static List<Room> roomsData = [
    Room(
      id: 1,
      name: 'Bedroom',
      image: 'assets/images/Homepage/bedroom.jpg',
      devices: [
        Device(type: 'Light', name: 'LED', isActive: true),
        Device(type: 'Light', name: 'LED', isActive: false),
        Device(type: 'Air Conditioner', name: 'Ax125', isActive: true),
      ],
      /* lightDevices: [
          LightDevice(name: 'LED', isActive: true),
          LightDevice(name: 'LED', isActive: false),
        ],
        airConditioners: [
          AirConditioner(name: 'Ax125', isActive: true),
        ], */
      sensors: [
        Sensor(type: 'Temperature Sensor', name: 'DHT11', value: 25),
        Sensor(type: 'Light Sensor', name: 'Light Sensor', value: 100),
        Sensor(type: 'Sound Sensor', name: 'Sound Sensor', value: 35),
        Sensor(type: 'Humidity Sensor', name: 'Humidity Sensor', value: 69)
      ],
      /* tempSensors: TempSensor(name: 'DHT11', value: 25),
        lightSensors: LightSensor(name: 'Light Sensor', value: 100),
        soundSensors: SoundSensor(name: 'Sound Sensor', value: 35),
        humiditySensors: HumiditySensor(name: 'Humidity Sensor', value: 69) */
    ),
    Room(
      id: 2,
      name: 'Living room',
      image: 'assets/images/Homepage/living_room.jpg',
      devices: [
        Device(type: 'Light', name: 'LED', isActive: true),
        Device(type: 'Light', name: 'LED', isActive: false),
        Device(type: 'Light', name: 'LED', isActive: true),
        Device(type: 'Light', name: 'LED', isActive: true),
        Device(type: 'Air Conditioner', name: 'Ax125', isActive: true),
        Device(type: 'Air Conditioner', name: 'Ax124', isActive: false),
      ],
      /* lightDevices: [
          LightDevice(name: 'LED', isActive: true),
          LightDevice(name: 'LED', isActive: false),
          LightDevice(name: 'LED', isActive: true),
          LightDevice(name: 'LED', isActive: true),
        ],
        airConditioners: [
          AirConditioner(name: 'As125', isActive: true),
          AirConditioner(name: 'As124', isActive: true),
        ], */
      sensors: [
        Sensor(type: 'Temperature Sensor', name: 'DHT11', value: 30),
        Sensor(type: 'Light Sensor', name: 'Light Sensor', value: 300),
        Sensor(type: 'Sound Sensor', name: 'Sound Sensor', value: 85),
        Sensor(type: 'Humidity Sensor', name: 'Humidity Sensor', value: 69)
      ],
      /* tempSensors: TempSensor(name: 'DHT11', value: 30),
        lightSensors: LightSensor(name: 'Light Sensor', value: 300),
        soundSensors: SoundSensor(name: 'Sound Sensor', value: 85),
        humiditySensors: HumiditySensor(name: 'Humidity Sensor', value: 69) */
    ),
  ];

  static int countDeviceByType(String _type, int _key) {
    int result = 0;
    List _devices = RoomsModel.roomsData[_key].devices;

    _devices.asMap().forEach((int key, dynamic value) {
      if (value.type == _type) result++;
    });

    return result;
  }

  static int getValueFromSensor(String _type, int _key) {
    int foundValue;
    List _sensors = RoomsModel.roomsData[_key].sensors;

    _sensors.asMap().forEach((int key, dynamic value) {
      if (value.type == _type) {
        foundValue = RoomsModel.roomsData[_key].sensors[key].value;
      }
    });
    return foundValue;
  }

  Room getById(int id) => Room(
      id: id,
      name: roomsData[id % roomsData.length].name,
      image: roomsData[id % roomsData.length].image,
      lightDevices: roomsData[id % roomsData.length].lightDevices,
      airConditioners: roomsData[id % roomsData.length].airConditioners,
      tempSensors: roomsData[id % roomsData.length].tempSensors,
      lightSensors: roomsData[id % roomsData.length].lightSensors,
      soundSensors: roomsData[id % roomsData.length].soundSensors);

  Room getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Room {
  Room({
    this.id,
    this.name,
    this.image,
    this.devices,
    this.lightDevices,
    this.airConditioners,
    this.sensors,
    this.tempSensors,
    this.lightSensors,
    this.soundSensors,
    this.humiditySensors,
  });

  final int id;
  final String name;
  final String image;
  final List<Device> devices;
  final List<LightDevice> lightDevices;
  final List<AirConditioner> airConditioners;
  final List<Sensor> sensors;
  final TempSensor tempSensors;
  final LightSensor lightSensors;
  final SoundSensor soundSensors;
  final HumiditySensor humiditySensors;
}

class LightDevice {
  LightDevice({
    this.name,
    this.isActive,
  });

  final String name;
  bool isActive;
}

class AirConditioner {
  AirConditioner({
    this.name,
    this.isActive,
  });

  final String name;
  bool isActive;
}

class TempSensor {
  TempSensor({
    this.name,
    this.value,
  });

  final String name;
  int value;
}

class LightSensor {
  LightSensor({
    this.name,
    this.value,
  });

  final String name;
  int value;
}

class SoundSensor {
  SoundSensor({
    this.name,
    this.value,
  });

  final String name;
  int value;
}

class HumiditySensor {
  HumiditySensor({
    this.name,
    this.value,
  });

  final String name;
  int value;
}

class Device {
  Device({this.type, this.name, this.isActive});

  final String type;
  final String name;
  bool isActive;
}

class Sensor {
  Sensor({this.type, this.name, this.value});

  final String type;
  final String name;
  int value;
}
