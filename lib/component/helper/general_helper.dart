
import 'package:intl/intl.dart';

class GeneralHelper {

  //  General Method:-----------------------------------------------------------
  String dateFormatter(String date) {
    var parseDate = DateTime.parse(date);
    var formatter = new DateFormat('MMM, dd yyyy HH:mm');
    return formatter.format(parseDate);
  }

  String currencyFormatter(String currency) {
    var parseString = currency.toString();
    var formatter = new NumberFormat.currency(decimalDigits: 2);
    return formatter.format(parseString);
  }

}