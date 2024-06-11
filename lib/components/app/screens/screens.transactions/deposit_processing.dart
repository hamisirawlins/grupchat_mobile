import 'package:flutter/material.dart';
import 'package:grupchat/components/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/components/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

class DepositProcessing extends StatelessWidget {
  static const String routeName = '/deposit-processing';
  final String poolId;
  const DepositProcessing({super.key, required this.poolId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.16,
            ),
            MultiCircularSlider(
                size: SizeConfig.screenWidth * 0.8,
                progressBarType: MultiCircularSliderType.circular,
                values: const [0.2, 0.1, 0.3, 0.25, 0.15],
                colors: [
                  const Color(0xFF6254fa).withOpacity(0.2),
                  const Color(0xFF6254fa).withOpacity(0.4),
                  const Color(0xFF6254fa).withOpacity(0.6),
                  const Color(0xFF6254fa).withOpacity(0.8),
                  const Color(0xFF6254fa)
                ],
                showTotalPercentage: false,
                trackWidth: 16.0),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            const Text('Processing Request...'),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.12),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                backgroundColor: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.024),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.08),
              child: const Text(
                "If You Don't Receive The M-Pesa Pop Up, Please Use The Following Details To Manually Complete The Transaction",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.024),
            const Text(
              'PayBill: 123456',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.008),
            const Text(
              'Account Number: 07XXXXXXXX',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.05),
              child: NonBorderedButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PoolDetails.routeName, (route) => false,
                        arguments: poolId);
                  },
                  text: 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
