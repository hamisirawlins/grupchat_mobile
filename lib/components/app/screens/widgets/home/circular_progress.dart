import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final int currentValue;
  final int totalValue;
  final double linewidth;
  final double radius;

  const CustomCircularProgressIndicator({
    Key? key,
    required this.currentValue,
    required this.totalValue,
    required this.radius,
    required this.linewidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage of progress
    double percent = currentValue / totalValue;

    // Format the percentage to display with two decimal places
    String formattedPercent =
        NumberFormat("##0.#", "en_US").format(percent * 100);

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: linewidth,
      percent: percent,
      center: Text(
        "$formattedPercent%",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      progressColor: Colors.green[400],
      backgroundColor: Colors.green[100]!,
    );
  }
}
