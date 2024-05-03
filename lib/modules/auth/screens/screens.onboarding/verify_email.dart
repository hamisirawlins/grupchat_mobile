import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/success_screen.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_action_button.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const String routeName = '/verify-email';
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  void resendEmail() async {
    // read arguments passed by pushNamed
    final email = ModalRoute.of(context)!.settings.arguments as String;
    // send email verification link using supabase
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          });
      await supabase.auth.resend(type: OtpType.signup, email: email);
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(
            context, "Email Verification link resent successfully to $email");
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        // log error
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(CupertinoIcons.clear),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginAndRegisterView.routeName, (route) => false);
              }),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(SizeConfig.screenHeight * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.002,
            ),
            Image(
              image: const AssetImage("assets/images/envelope.png"),
              height: SizeConfig.screenHeight * 0.28,
            ),
            Text("Verify Email",
                style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 46,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: SizeConfig.screenHeight * 0.024,
            ),
            Text(
              "Please check your mail to verify your account",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.black38, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.024,
            ),
            Text(
              "Congratulations! A world of endless possibilities awaits you and your friends. Pool funds and power through those group plans! 🚀",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            AuthActionButton(
              onTap: () {
                try {
                  // check if user is verified
                  final user = supabase.auth.currentSession?.user;
                  if (user != null && user.emailConfirmedAt != null) {
                    Navigator.pushNamed(context, SuccessScreen.routeName);
                  } else {
                    showSnackBar(context, "Email not verified yet");
                  }
                } catch (e) {
                  showSnackBar(context, e.toString());
                }
              },
              text: "Continue",
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.024,
            ),
            GestureDetector(
              onTap: resendEmail,
              child: Text(
                "Resend Email",
                style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
