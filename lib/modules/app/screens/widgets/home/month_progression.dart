import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MonthlyProgressIndicator extends StatelessWidget {
  const MonthlyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Get the total number of days in the current month
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;

    // Calculate the percentage of the month that has passed
    double percent = now.day / totalDaysInMonth;

    // Format the percentage to display with two decimal places
    String formattedPercent =
        NumberFormat("##0.0#", "en_US").format(percent * 100);

    return CircularPercentIndicator(
      radius: SizeConfig.screenWidth * 0.14,
      lineWidth: 5.0,
      percent: percent,
      center: Text(
        "$formattedPercent%",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      progressColor: Colors.green,
      backgroundColor: Colors.grey[300]!,
    );
  }
}
