class DeviceModel {
  DeviceModel({this.account, this.data, this.name, this.topic, this.update});

  final String account;
  final String data;
  final String name;
  final String topic;
  final String update;

  factory DeviceModel.fromJson(dynamic json) {
    return DeviceModel(
      account: json['account'].toString(),
      data: json['data'].toString(),
      name: json['name'].toString(),
      topic: json['topic'].toString(),
      update: json['update'].toString(),
    );
  }
}
