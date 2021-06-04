import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class RealtimeSensors {
  /// This is for listening realtime update
  final _sensorReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
            'name',
            isNotEqualTo: 'RELAY',
          );
  StreamController<Map<String, double>> _controller =
      StreamController<Map<String, double>>.broadcast();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _subscription;

  Map<String, double> strToIntDictionary = const {
    'LIGHT': 0.0,
    'TEMP-HUMID': 1.0,
    'SOUND': 2.0,
  };

  Map<double, String> intToStrDictionary = {
    0.0: 'LIGHT',
    1.0: 'TEMP-HUMID',
    2.0: 'SOUND',
  };

  bool isInit = false;
  Map<String, double> realtimeData = {
    'LIGHT': -1,
    'TEMP': -1,
    'HUMID': -1,
    'SOUND': -1,
    'CHANGED': -1,
  };

  /// Constantly listening to realtime update
  Stream listenToSensors() {
    _subscription = _sensorReference.snapshots().listen(
      (snapshot) {
        if (!isInit) {
          convertInit(snapshot.docs);
          if (!_controller.isClosed) _controller.sink.add(realtimeData);
        } else {
          snapshot.docChanges.forEach(
            (docChange) {
              convertDocData(docChange.doc.data());
              if (!_controller.isClosed) _controller.sink.add(realtimeData);
            },
          );
        }
      },
    );
    return _controller.stream;
  }

  void convertInit(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    for (var doc in docs) {
      if (doc.data()['name'] == 'TEMP-HUMID') {
        List<String> temp_humid = doc.data()['data'].split('-');
        realtimeData['TEMP'] = double.parse(temp_humid[0]);
        realtimeData['HUMID'] = double.parse(temp_humid[1]);
      } else {
        realtimeData[doc.data()['name']] = double.parse(doc.data()['data']);
      }
    }
  }

  /// Convert Document Data into Map<String, int> and save at this.realtimeData
  void convertDocData(Map<String, dynamic> sensorData) {
    String data = sensorData['data'];

    // TODO: Only the changed document is presented
    if (sensorData['name'] != 'TEMP-HUMID') {
      realtimeData[sensorData['name']] = double.parse(data);
    } else {
      List<String> temp_humid = data.split('-');
      realtimeData['TEMP'] = double.parse(temp_humid[0]);
      realtimeData['HUMID'] = double.parse(temp_humid[1]);
    }
    realtimeData['CHANGED'] = strToIntDictionary[sensorData['name']];
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }
}
