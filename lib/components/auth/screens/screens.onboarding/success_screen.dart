import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/components/auth/screens/screens.login/login_screen.dart';
import 'package:grupchat/components/auth/screens/widgets/auth_action_button.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class SuccessScreen extends StatelessWidget {
  static const String routeName = '/success-screen';
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenHeight * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.072,
              ),
              Image(
                image: const AssetImage("assets/images/team-work.png"),
                height: SizeConfig.screenHeight * 0.28,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.024,
              ),
              Text("Your Account Was Created Successfully!",
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(
                height: SizeConfig.screenHeight * 0.024,
              ),
              Text(
                "Enjoy world of financial comfort among your friends. Let those plans transend the group chat! 🚀",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              AuthActionButton(
                  text: "Continue",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.routeName, (route) => false);
                  }),
              SizedBox(
                height: SizeConfig.screenHeight * 0.024,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
