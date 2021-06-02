import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class RealtimeSensors {
  /// This is for listening realtime update
  final _sensorReference =
      FirebaseFirestore.instance.collection('Tam_feed').where(
            'name',
            isNotEqualTo: 'RELAY',
          );
  StreamController<Map<String, int>> _controller =
      StreamController<Map<String, int>>();

  // TODO: This value may be useful when seeing RealTimeSensors as a provider.
  Map<String, int> realtimeData = {
    'LIGHT': 0,
    'TEMP': 0,
    'HUMID': 0,
    'SOUND': 0,
  };

  /// Constantly listening to realtime update
  Stream listenToSensors() {
    _sensorReference.snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((docChange) {
        convertDocData(docChange.doc.data());
        _controller.add(realtimeData);
      });
    });
    return _controller.stream;
  }

  /// Convert Document Data into Map<String, int> and save at this.realtimeData
  void convertDocData(Map<String, dynamic> sensorData) {
    String data = sensorData['data'];

    // TODO: Only the changed document is presented
    if (sensorData['name'] != 'TEMP-HUMID') {
      realtimeData[sensorData['name']] = int.parse(data);
    } else {
      List<String> temp_humid = data.split('-');
      realtimeData['TEMP'] = int.parse(temp_humid[0]);
      realtimeData['HUMID'] = int.parse(temp_humid[1]);
    }
  }

  void dispose() {
    _controller.close();
  }
}
