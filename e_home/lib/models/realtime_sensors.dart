import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class RealtimeSensors {
  // This is for listening realtime update
  final _sensorReference = FirebaseFirestore.instance.collection('Tam_feed');
  StreamController<Map<String, int>> _controller =
      StreamController<Map<String, int>>();

  Map<String, int> realtimeData = {
    'LIGHT': 0,
    'TEMP': 0,
    'HUMID': 0,
    'SOUND': 0,
  };

  Stream listenToSensors() {
    _sensorReference.snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((docChange) {
        if (docChange.type == DocumentChangeType.added ||
            docChange.type == DocumentChangeType.modified) {
          convertDocData(docChange.doc.data());
          _controller.add(realtimeData);
        }
      });
    });
    return _controller.stream;
  }

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
