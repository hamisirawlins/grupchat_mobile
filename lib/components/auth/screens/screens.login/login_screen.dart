import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../utils/constants/sys_util.dart';
import '../widgets/auth_action_button.dart';
import '../widgets/auth_input_field.dart';
import '../../../../widgets/show_snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  final Function()? toggleScreen;
  LoginScreen({super.key, this.toggleScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//Sign In
  void signIn() async {
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
      await supabase.auth.signInWithPassword(
          email: emailController.text, password: passwordController.text);
      if (mounted) {
        Navigator.pop(context);
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        showSnackBar(context, e.message);
      }
    } on AuthException catch (e) {
      if (mounted) {
        showSnackBar(context, e.message);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void googleSignIn() async {
    try {
      //google sign in
      final googleSignIn = GoogleSignIn(
        clientId: dotenv.env['IOS_CLIENT'] ?? '',
        serverClientId: dotenv.env['WEB_CLIENT'] ?? '',
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (mounted) {
        showSnackBar(context, "Welcome!");
        Navigator.pushNamedAndRemoveUntil(
            context, HomeView.routeName, (route) => false);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, "Google Sign In Failed");
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.screenHeight * 0.008),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),
              AuthActionButton(text: "Login", onTap: signIn),
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
                        "Or",
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.screenWidth * 0.02),
                child: GestureDetector(
                  onTap: googleSignIn,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: kPrimaryColor, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logos/google.png',
                            width: SizeConfig.screenHeight * 0.028,
                            height: SizeConfig.screenHeight * 0.028),
                        const SizedBox(width: 10),
                        const Text(
                          "Sign In With Google",
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign-up');
                    },
                    child: const Text(
                      "Register",
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
