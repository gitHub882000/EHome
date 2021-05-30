import 'package:intl/intl.dart';

final inDateFormat = DateFormat('dd-MM-yy');
final outDateFormat = DateFormat('yy-MM-dd');

DateTime convertDateFormat(String dt) {
  final inDate = inDateFormat.parse(dt.substring(9));
  return outDateFormat.parse('$inDate');
}