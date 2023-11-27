import 'package:intl/intl.dart';

class Utilities {
  static String formatDate(int millis) {
    DateFormat now = DateFormat.yMd().add_jm();
    return now.format(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
