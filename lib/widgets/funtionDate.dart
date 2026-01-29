import 'package:intl/intl.dart';

String getthedate(String daate){
  DateTime dateTime = DateTime.parse(daate);

  // Format to extract only the date
  String date = DateFormat('dd-MM-yyyy  h:m:s').format(dateTime);
  return date;

}