import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:e_home/utils/date_util.dart';

class SensorHistory {
  /// This is for fetching history
  final _sensorReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
    'name',
    whereIn: ['LIGHT', 'TEMP-HUMID', 'SOUND'],
  );
  StreamController<Map<String, List<dynamic>>> _controller =
      StreamController<Map<String, List<dynamic>>>.broadcast();
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

  /// Convert Document Data into Map<String, List<dynamic>>
  /// and save at this.historyData
  void convertDocHistory(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    DateTime maxLastDay = DateTime(2021, 1, 1);
    int maxSize = -1;

    for (var doc in docs) {
      DateTime lastDay = convertDateFormat(doc.data()['history'].last['date']);
      maxLastDay = lastDay.isAfter(maxLastDay) ? lastDay : maxLastDay;
      maxSize = maxSize < doc.data()['history'].length
          ? doc.data()['history'].length
          : maxSize;
    }

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
      history = maxSize <= 7
          ? history
          : convertDateFormat(history.last['date']).isBefore(maxLastDay)
              ? history.sublist(history.length - 6)
              : history.sublist(history.length - 7);
      if (doc.data()['name'] == 'TEMP-HUMID') {
        for (int i = 0; i < history.length; i++) {
          List<String> splits = history[i]['data'].split('-');
          historyData['TEMP'][i] = double.parse(splits[0]);
          historyData['HUMID'][i] = double.parse(splits[1]);
        }
      } else {
        for (int i = 0; i < history.length; i++) {
          historyData[doc.data()['name']][i] = history[i]['data'] is double
              ? history[i]['data']
              : history[i]['data'].toDouble();
        }
      }
    }
    historyData['DATE'] = maxSize > 7
        ? List.generate(7, (index) => maxLastDay.add(Duration(days: index - 6)))
        : List.generate(
            7,
            (index) => convertDateFormat(docs[0].data()['history'][0]['date'])
                .add(Duration(days: index)));
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }
}
