class Device {
  final String name;
  final String value;

  Device({this.name, this.value});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      name: json['name'],
      value: json['value'],
    );
  }
}