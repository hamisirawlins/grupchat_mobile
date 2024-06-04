import 'package:grupchat/models/pool_list.dart';
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

  static String reverseFormatPhoneNumber(String number) {
    return "0${number.substring(3)}";
  }

  static String formatAmount(var amount) {
    final NumberFormat kesCurrency = NumberFormat('#,##0.00', 'en_US');
    return kesCurrency.format(amount);
  }

  static String formatDate(String date) {
    return DateFormat('dd MMM yy').format(DateTime.parse(date));
  }

  static String formatShortDate(String date) {
    return DateFormat('dd MMM').format(DateTime.parse(date));
  }

  static String formatDateTime(String date) {
    final formattedDate =
        DateFormat('dd MMM, hh:mm a').format(DateTime.parse(date));
    return formattedDate;
  }

  static double getPoolProgress(PoolListItem pool) {
    return pool.insights.totalDeposits / pool.targetAmount;
  }
}