import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:e_home/utils/date_util.dart';

class SensorHistory {
  /// This is for fetching history
  final _sensorReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
            'name',
            isNotEqualTo: 'RELAY',
          );
  StreamController<Map<String, List<dynamic>>> _controller =
      StreamController<Map<String, List<dynamic>>>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _subscription;

  // TODO: This value may be useful when seeing SensorHistory as a provider.
  Map<String, List<dynamic>> historyData = {
    'DATE': []..length = 7,
    'LIGHT': []..length = 7,
    'TEMP': []..length = 7,
    'HUMID': []..length = 7,
    'SOUND': []..length = 7,
  };

  /// Constantly listening to realtime update
  Stream listenToSensorHistory() {
    _subscription = _sensorReference.snapshots().listen((snapshot) {
      convertDocHistory(snapshot.docs);
      if (!_controller.isClosed) _controller.sink.add(historyData);
    });
    return _controller.stream;
  }

  void convertDocHistory(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    DateTime maxFirstDay = DateTime(2021, 1, 1);

    for (var doc in docs) {
      DateTime firstDay = convertDateFormat(doc.data()['history'][0]['date']);
      maxFirstDay = firstDay.isAfter(maxFirstDay) ? firstDay : maxFirstDay;
    }

    /// Trace every doc, pass data into 4 lists
    for (var doc in docs) {
      if (doc.data()['name'] == 'TEMP-HUMID') {
        historyData['TEMP'] = List.generate(7, (_) => -1.0);
        historyData['HUMID'] = List.generate(7, (_) => -1.0);
      } else {
        historyData[doc.data()['name']] = List.generate(7, (_) => -1.0);
      }
      List<Map<String, dynamic>> history = (doc.data()['history'] as List)
          .map((element) => {
                'date': element['date'],
                'data': element['data'],
              })
          .toList();
      if (!convertDateFormat(history[0]['date']).isBefore(maxFirstDay)) {
        if (doc.data()['name'] == 'TEMP-HUMID') {
          for (int i = 0; i < history.length; i++) {
            List<String> splits = history[i]['data'].split('-');
            historyData['TEMP'][i] = double.parse(splits[0]);
            historyData['HUMID'][i] = double.parse(splits[1]);
          }
        } else {
          for (int i = 0; i < history.length; i++) {
            historyData[doc.data()['name']][i] = history[i]['data'];
          }
        }
      }
    }
    historyData['DATE'] =
        List.generate(7, (index) => maxFirstDay.add(Duration(days: index)));
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }
}
