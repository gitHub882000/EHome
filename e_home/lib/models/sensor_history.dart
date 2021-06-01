import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:e_home/utils/date_util.dart';

class SensorHistoryCell {
  DateTime date;
  double data;

  SensorHistoryCell() {
    date = DateTime(2021);
    data = -1;
  }

  SensorHistoryCell.withValues(String dt, double val) {
    date = convertDateFormat(dt);
    data = val;
  }
}

class SensorHistory {
  /// This is for fetching history
  final _sensorReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
            'name',
            isNotEqualTo: 'RELAY',
          );
  StreamController<Map<String, int>> _controller =
      StreamController<Map<String, int>>();

  // TODO: This value may be useful when seeing SensorHistory as a provider.
  Map<String, List<dynamic>> historyData = {
    'DATE': List.generate(7, (_) => DateTime(2020)),
    'LIGHT': List.generate(7, (_) => -1.0),
    'TEMP': List.generate(7, (_) => -1.0),
    'HUMID': List.generate(7, (_) => -1.0),
    'SOUND': List.generate(7, (_) => -1.0),
  };

  /// Constantly listening to realtime update
  Stream listenToSensorHistory() {
    _sensorReference.snapshots().listen((snapshot) {});
    return _controller.stream;
  }

  /// Convert Document Data into Map<String, int> and save at this.realtimeData
  void convertDocHistory(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    int maxSize = -1;
    DateTime maxFirstDay = DateTime(2021, 1, 1);

    /// List<<DateTime, double>>
    List<SensorHistoryCell> lightHistory = [];
    List<SensorHistoryCell> tempHistory = [];
    List<SensorHistoryCell> humidHistory = [];
    List<SensorHistoryCell> soundHistory = [];

    for (var doc in docs) {
      List<Map<String, dynamic>> history = doc.data()['history'];
      DateTime firstDay = convertDateFormat(history[0]['date']);
      maxSize = history.length > maxSize ? history.length : maxSize;
      maxFirstDay = firstDay.isAfter(maxFirstDay) ? firstDay : maxFirstDay;
    }

    /// Trace every doc, pass data into 4 lists
    for (var doc in docs) {
      List<Map<String, dynamic>> history = doc.data()['history'];
      if (convertDateFormat(history[0]['date']).isBefore(maxFirstDay)) {
        if (doc.data()['name'] == 'TEMP-HUMID') {
          historyData['TEMP'] = List.generate(7, (_) => -1.0);
          historyData['HUMID'] = List.generate(7, (_) => -1.0);
        } else {
          historyData[doc.data()['name']] = List.generate(7, (_) => -1.0);
        }
        break;
      }
      else {
        if (doc.data()['name'] == 'TEMP-HUMID') {

        }
      }
      for (var cell in history) {
        if (doc.data()['name'] == 'TEMP-HUMID') {
          List<String> splits = cell['data'].split('-');
          tempHistory.add(SensorHistoryCell.withValues(
              cell['date'], double.parse(splits[0])));
          humidHistory.add(SensorHistoryCell.withValues(
              cell['date'], double.parse(splits[1])));
        } else if (doc.data()['name'] == 'LIGHT') {
          for (int i = 0; i < history.length; i++) {
            lightHistory.add(
                SensorHistoryCell.withValues(cell['date'], history[i]['data']));
          }
        } else {
          for (int i = 0; i < history.length; i++) {
            soundHistory.add(
                SensorHistoryCell.withValues(cell['date'], history[i]['data']));
          }
        }
      }
    }
  }

  void dispose() {
    _controller.close();
  }
}
