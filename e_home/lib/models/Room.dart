class Room {
  final String name;
  final String image;
  final List<LightDevice> lightDevices;
  final List<AirConditioner> airConditioners;

  Room({
    this.name,
    this.image,
    this.lightDevices,
    this.airConditioners,
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
  ),
];
