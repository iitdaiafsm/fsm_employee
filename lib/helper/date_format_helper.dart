import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatHelper {
  static String convertDateFromDate(DateTime dateTime, String newFormat) {
    try {
      initializeDateFormatting();
      DateFormat newDateFormat = DateFormat(
        newFormat,
      );
      String selectedDate = newDateFormat.format(dateTime);
      return selectedDate;
    } catch (e) {
      return "";
    }
  }

  static String convertDateFromString(
      String dateTimeString, String oldFormat, String newFormat) {
    initializeDateFormatting();

    DateFormat newDateFormat = DateFormat(
      newFormat,
    );
    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }
  static DateTime convertToDateFromString(
      String dateTimeString, String oldFormat) {
    initializeDateFormatting();

    DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
    return dateTime;
  }
}
