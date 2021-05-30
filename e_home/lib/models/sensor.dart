class Sensor {
  final String name;
  final String type;

  /// datum is realtime value
  /// data is a list of weekly values
  int datum;
  List<int> data;

  Sensor(this.name, this.type);
}
