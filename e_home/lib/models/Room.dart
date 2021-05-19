import 'package:flutter/material.dart';

class RoomsModel {
  static List<Room> roomsData = [
    Room(
      id: 1,
      name: 'Bedroom',
      image: 'assets/images/Homepage/bedroom.jpg',
      lightDevices: [
        LightDevice(name: 'LED', isActive: true),
        LightDevice(name: 'LED', isActive: false),
      ],
      airConditioners: [
        AirConditioner(name: 'Ax125', isActive: true),
      ],
      tempSensors: TempSensor(name: 'DHT11', value: 25),
      lightSensors: LightSensor(name: 'Light Sensor', value: 100),
      soundSensors: SoundSensor(name: 'Sound Sensor', value: 35),
    ),
    Room(
      id: 2,
      name: 'Living room',
      image: 'assets/images/Homepage/living_room.jpg',
      lightDevices: [
        LightDevice(name: 'LED', isActive: true),
        LightDevice(name: 'LED', isActive: false),
        LightDevice(name: 'LED', isActive: true),
        LightDevice(name: 'LED', isActive: true),
      ],
      airConditioners: [
        AirConditioner(name: 'As125', isActive: true),
        AirConditioner(name: 'As124', isActive: true),
      ],
      tempSensors: TempSensor(name: 'DHT11', value: 30),
      lightSensors: LightSensor(name: 'Light Sensor', value: 300),
      soundSensors: SoundSensor(name: 'Sound Sensor', value: 85),
    ),
  ];

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
    this.lightDevices,
    this.airConditioners,
    this.tempSensors,
    this.lightSensors,
    this.soundSensors,
  });

  final int id;
  final String name;
  final String image;
  final List<LightDevice> lightDevices;
  final List<AirConditioner> airConditioners;
  final TempSensor tempSensors;
  final LightSensor lightSensors;
  final SoundSensor soundSensors;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Room && runtimeType == other.runtimeType && other.id == id;

  Map<String, dynamic> toRoom() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'lightDevices': lightDevices,
      'airConditioners': airConditioners,
      'tempSensors': tempSensors,
      'lightSensors': lightSensors,
      'soundSensors': soundSensors,
    };
  }
}

class LightDevice {
  LightDevice({
    this.name,
    this.isActive,
  });

  final String name;
  final bool isActive;
}

class AirConditioner {
  AirConditioner({
    this.name,
    this.isActive,
  });

  final String name;
  final bool isActive;
}

class TempSensor {
  TempSensor({
    this.name,
    this.value,
  });

  final String name;
  final int value;
}

class LightSensor {
  LightSensor({
    this.name,
    this.value,
  });

  final String name;
  final int value;
}

class SoundSensor {
  SoundSensor({
    this.name,
    this.value,
  });

  final String name;
  final int value;
}
