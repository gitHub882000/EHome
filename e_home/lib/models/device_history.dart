import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:e_home/utils/date_util.dart';

class DeviceHistory {
  /// This is for fetching history
  final _deviceReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
            'name',
            isEqualTo: 'RELAY',
          );
  StreamController<Map<String, List<dynamic>>> _controller =
      StreamController<Map<String, List<dynamic>>>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _subscription;

  // TODO: This value may be useful when seeing SensorHistory as a provider.
  Map<String, List<dynamic>> historyData = {
    'DATE': []..length = 7,
    'RELAY': List.generate(7, (_) => -1.0),
  };

  /// Constantly listening to realtime update
  Stream listenToDeviceHistory() {
    _subscription = _deviceReference.snapshots().listen((snapshot) {
      convertDocHistory(snapshot.docs);
      if (!_controller.isClosed) _controller.sink.add(historyData);
    });
    return _controller.stream;
  }

  /// Convert Document Data into Map<String, List<dynamic>>
  /// and save at this.historyData
  void convertDocHistory(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    for (var doc in docs) {
      List<Map<String, dynamic>> history = (doc.data()['history'] as List)
          .map((element) => {
                'date': element['date'],
                'data': element['data'],
              })
          .toList();
      history =
          history.length <= 7 ? history : history.sublist(history.length - 7);
      for (int i = 0; i < history.length; i++) {
        historyData['RELAY'][i] = history[i]['data'] is double
            ? history[i]['data'] * 24.0
            : history[i]['data'].toDouble() * 24.0;
      }

      final lastDay = convertDateFormat(history.last['date']);
      final firstDay = convertDateFormat(history.first['date']);
      historyData['DATE'] = history.length == 7
          ? List.generate(7, (index) => lastDay.add(Duration(days: index - 6)))
          : List.generate(7, (index) => firstDay.add(Duration(days: index)));
    }
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }
}
