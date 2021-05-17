class Room {
  final String name;
  final String image;
  final List<LightDevice> lightDevices;
  final List<AirConditioner> airConditioners;
  final List<TempSensor> tempSensors;
  final List<LightSensor> lightSensors;
  final List<SoundSensor> soundSensors;

  Room({
    this.name,
    this.image,
    this.lightDevices,
    this.airConditioners,
    this.tempSensors,
    this.lightSensors,
    this.soundSensors,
  });
}

class LightDevice {
  final String name;
  final bool isActive;

  LightDevice({
    this.name,
    this.isActive,
  });
}

class AirConditioner {
  final String name;
  final bool isActive;

  AirConditioner({
    this.name,
    this.isActive,
  });
}

class TempSensor {
  final String name;
  final int value;

  TempSensor({
    this.name,
    this.value,
  });
}

class LightSensor {
  final String name;
  final int value;

  LightSensor({
    this.name,
    this.value,
  });
}

class SoundSensor {
  final String name;
  final int value;

  SoundSensor({
    this.name,
    this.value,
  });
}

List roomsData = [
  Room(
    name: 'Bedroom',
    image: 'assets/images/Homepage/bedroom.jpg',
    lightDevices: [
      LightDevice(name: 'LED', isActive: true),
      LightDevice(name: 'LED', isActive: false),
    ],
    airConditioners: [
      AirConditioner(name: 'Ax125', isActive: true),
    ],
    tempSensors: [
      TempSensor(name: 'DHT11', value: 25),
    ],
    lightSensors: [
      LightSensor(name: 'Light Sensor', value: 100),
    ],
    soundSensors: [
      SoundSensor(name: 'Sound Sensor', value: 35),
    ],
  ),
  Room(
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
    tempSensors: [
      TempSensor(name: 'DHT11', value: 30),
    ],
    lightSensors: [
      LightSensor(name: 'Light Sensor', value: 300),
    ],
    soundSensors: [
      SoundSensor(name: 'Sound Sensor', value: 85),
    ],
  ),
];
