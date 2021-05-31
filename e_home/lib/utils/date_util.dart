import 'package:intl/intl.dart';

// TODO: This converts "jj:mm:ss MM-dd-yy" to DateTime
DateTime convertDateFormat(String date) {
  return DateTime(
    // Year
    int.parse('20' + date.substring(15)),
    // Month
    int.parse(date.substring(9, 11)),
    // Day
    int.parse(date.substring(12, 14)),
    // Hour
    int.parse(date.substring(0, 2)),
    // Minute
    int.parse(date.substring(3, 5)),
    // Second
    int.parse(date.substring(6, 8)),
  );
}
