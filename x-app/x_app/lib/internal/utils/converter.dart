import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Converter {
  static String formatNumeral({@required var numberDouble}) {
    double number = 0.0;
    if ((numberDouble is String)) {
      try {
        number = double.parse(numberDouble);
      } catch (ex) {
        throw Exception("Numeric Dönüştürme Hatası. Hata:" + ex.toString());
      }
    } else {
      number = numberDouble;
    }
    NumberFormat formatter = new NumberFormat("#,###.00", "tr");

    return formatter.format(number);
  }

  static String DateTimeToString(DateTime date) {
    return ((date.day < 10) ? "0" + date.day.toString() : date.day.toString()) +
        "/" +
        ((date.month < 10)
            ? "0" + date.month.toString()
            : date.month.toString()) +
        "/" +
        date.year.toString();
  }
}
