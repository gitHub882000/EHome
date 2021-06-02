import 'package:intl/intl.dart';

// TODO: This converts "jj:mm:ss MM-dd-yy" to DateTime
DateTime convertDateFormat(String date) {
  return DateTime(
    // Year
    int.parse('20' + date.substring(6)),
    // Month
    int.parse(date.substring(0, 2)),
    // Day
    int.parse(date.substring(3, 5)),
  );
}
