import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class TotalPooled extends StatelessWidget {
  const TotalPooled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Total Pooled:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 0.024,
        ),
        const Text(
          "Ksh. 873,270.00",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
