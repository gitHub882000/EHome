import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class RealtimeSensor {
  /// This is for listening realtime update
  final _sensorReference;
  final String name;

  RealtimeSensor(this.name)
      : _sensorReference =
            FirebaseFirestore.instance.collection('Tam_feed').where(
                  'name',
                  isEqualTo: name,
                );

  StreamController<Map<String, double>> _controller =
      StreamController<Map<String, double>>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _subscription;

  Map<String, double> realtimeData = {
    'LIGHT': -1,
    'TEMP': -1,
    'HUMID': -1,
    'SOUND': -1,
  };

  int counter = 0;

  /// Constantly listening to realtime update
  Stream listenToSensors() {
    _subscription = _sensorReference.snapshots().listen(
      (snapshot) {
        if (counter != 2) {
          convertDocData(snapshot.docs);
          if (!_controller.isClosed) _controller.sink.add(realtimeData);
          counter++;
        }
        else {
          counter--;
        }
      },
    );
    return _controller.stream;
  }

  void convertDocData(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    for (var doc in docs) {
      if (name == 'TEMP-HUMID') {
        List<String> temp_humid = doc.data()['data'].split('-');
        realtimeData['TEMP'] = double.parse(temp_humid[0]);
        realtimeData['HUMID'] = double.parse(temp_humid[1]);
      } else {
        realtimeData[name] = double.parse(doc.data()['data']);
      }
    }
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }
}
