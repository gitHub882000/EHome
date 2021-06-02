class DeviceModel {
  DeviceModel({this.name, this.value});

  final String name;
  final String value;

  factory DeviceModel.fromJson(dynamic json) {
    return DeviceModel(
      name: json['name'].toString(),
      value: json['value'].toString(),
    );
  }
}
