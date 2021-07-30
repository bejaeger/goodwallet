import 'package:intl/intl.dart';

getMonth(int microsecondsSinceEpoch) {
  final date =
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch * 1000);
  return DateFormat('MMMM').format(date);
}
