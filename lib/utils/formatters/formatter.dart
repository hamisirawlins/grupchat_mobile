import 'package:intl/intl.dart';

class UtilFormatter {
  static String formatPhoneNumber(String number) {
    if (number.startsWith("254") && number.length == 12) {
      return number;
    }
    if (number.startsWith("0") && number.length == 10) {
      return "254${number.substring(1)}";
    }
    if (number.startsWith("+254") && number.length == 13) {
      return "254${number.substring(4)}";
    }
    return number;
  }

  static String formatAmount(var amount) {
    final NumberFormat kesCurrency = NumberFormat('#,##0.00', 'en_US');
    return kesCurrency.format(amount);
  }

  static String formatDate(String date) {
    return DateFormat('dd MMM yy').format(DateTime.parse(date));
  }
}
