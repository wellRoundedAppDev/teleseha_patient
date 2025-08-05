import 'package:intl/intl.dart';

/// This function accepts input like "20/07/2024 00:00:00" passed as string and checks if the date is after the current date.
bool isDate1AfterDate2(String date1, String date2) {
  // 20/07/2024 00:00:00 this is an example format of date
  return getDateTimeFromString(date1).isAfter(getDateTimeFromString(date2));
}

DateTime getDateTimeFromString(String date) {
  final List<String> dateParts = date.split(' ');
  final List<String> dateParts1 = dateParts[0].split('/');
  final List<String> dateParts2 = dateParts[1].split(':');
  return DateTime(
    int.parse(dateParts1[2]),
    int.parse(dateParts1[1]),
    int.parse(dateParts1[0]),
    int.parse(dateParts2[0]),
    int.parse(dateParts2[1]),
    int.parse(dateParts2[2]),
  );
}

String dateTimeToString(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
}
