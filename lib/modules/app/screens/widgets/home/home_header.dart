import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/modules/app/screens/widgets/home/total_pooled.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.28,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            kPrimaryColor,
            Colors.blue.shade900,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Powering Plans",
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Beyond The Group Chat",
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.018),
            const TotalPooled(),
            SizedBox(height: SizeConfig.screenHeight * 0.022),
          ],
        ),
      ),
    );
  }
}
