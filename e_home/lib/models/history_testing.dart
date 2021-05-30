import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_home/utils/constants_util.dart';

class HDate {
  DateTime date;

  HDate(String dt) {
    final inDate = inDateFormat.parse(dt.substring(9));
    date = outDateFormat.parse('$inDate');
  }
}

class History {
  final firestoreInstance = FirebaseFirestore.instance;

}