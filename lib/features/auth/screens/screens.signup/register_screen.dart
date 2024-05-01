import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/data/services/auth_service.dart';
import 'package:grupchat/features/auth/screens/screens.onboarding/verify_email.dart';
import 'package:grupchat/features/auth/screens/widgets/terms_and_conditions_check.dart';
import 'package:grupchat/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../utils/constants/sys_util.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../../../../common/widgets/show_snackbar.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? toggleScreen;
  const RegisterScreen({super.key, this.toggleScreen});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//Terms Check
  bool isChecked = false;
  void toggleCheck() {
    setState(() {
      isChecked = !isChecked;
    });
  }

//Sign Up
  void signUp() async {
    if (emailController.text.isEmpty) {
      showSnackBar(context, 'Email is required');
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      showSnackBar(context, 'Please enter a valid email address');
      return;
    }
    if (passwordController.text.isEmpty) {
      showSnackBar(context, 'Password is required');
      return;
    }
    if (passwordController.text.length < 6) {
      showSnackBar(context, 'Password must be at least 6 characters long');
      return;
    }
    if (isChecked != true) {
      showSnackBar(context,
          'Please read and accept the Privacy Policy and Terms to proceed');
      return;
    }
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    try {
      final res = await supabase.auth.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      if (mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          VerifyEmailScreen.routeName,
          arguments: res,
        );
        showSnackBar(context, "Please check your email to verify your account");
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, e.message);
      }
    } on AuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, e.toString());
      }
    }
  }

  void googleSignIn() async {
    String response = await AuthService().signInWithGoogle();
    if (mounted) {
      if (response == 'failed') {
        showSnackBar(
            context, 'Failed to sign in with Google, Please try again later.');
      } else {
        showSnackBar(context, "Successfully Logged In!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Image.asset(
                'assets/images/padlock.png',
                width: SizeConfig.screenWidth * 0.28,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Text(
                "Grup Chat",
                style: GoogleFonts.raleway(
                    color: Colors.black45,
                    fontSize: 46,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              Text(
                "Powering plans beyond the group chart",
                style: GoogleFonts.raleway(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              AuthInput(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.024,
              ),
              AuthInput(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.024,
              ),
              TermsAndConditionsCheck(toggleCheck: toggleCheck),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              AuthActionButton(text: "Sign Up", onTap: signUp),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.02),
                      child: const Text(
                        "Or Continue With",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Center(
                child: GestureDetector(
                  onTap: googleSignIn,
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.screenWidth * 0.024),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                      'assets/icons/google.png',
                      width: SizeConfig.screenWidth * 0.12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.toggleScreen,
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
