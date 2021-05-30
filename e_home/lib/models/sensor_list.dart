import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_home/models/sensor.dart';

class SensorList extends ChangeNotifier {
  final firestoreInstance = FirebaseFirestore.instance;
  bool _areDatesInit = false;
  List<DateTime> dates = []..length = 7;
  List<Sensor> sensors = []..length = 4;

  Future<void> fetchSensorHistory() {

  }
}