class DeviceModel {
  DeviceModel({this.name, this.isActive, this.type});

  final String name;
  String isActive;
  final String type;

  factory DeviceModel.fromJson(dynamic json) {
    return DeviceModel(
        name: json['name'].toString(),
        isActive: json['isActive'].toString(),
        type: json['type'].toString());
  }
}
