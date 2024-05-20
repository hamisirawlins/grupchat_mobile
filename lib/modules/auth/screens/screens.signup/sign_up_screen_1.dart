import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/modules/auth/screens/screens.signup/add_phone_screen.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_action_button.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_input_field.dart';
import 'package:grupchat/modules/auth/screens/widgets/terms_and_conditions_check.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/local_storage/image_picker.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Uint8List? _imageSelection;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Terms Check
  bool isChecked = false;
  void toggleCheck() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  pickImage() async {
    Uint8List? file = await selectImage(ImageSource.gallery);
    if (mounted) {
      if (file == null) {
        showSnackBar(context, 'No image selected');
      } else {
        setState(() {
          _imageSelection = file;
        });
      }
    }
  }

  void googleSignUp() async {
        String response = await AuthService().signInWithGoogle();
    if (mounted) {
      if (response == 'failed') {
        showSnackBar(
            context, 'Failed to sign in with Google, Please try again later.');
      } else {
        Navigator.pushNamed(
            context, AddPhoneScreen.routeName);
        showSnackBar(context, "Successfully Logged In!");
      }
    }
  }

  void signUp() async {
    if (nameController.text.isEmpty) {
      showSnackBar(context, 'Name is required');
      return;
    }
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
          AddPhoneScreen.routeName,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _imageSelection == null
                              ? Container(
                                  width: SizeConfig.screenHeight * 0.16,
                                  height: SizeConfig.screenHeight * 0.16,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(500)))
                              : Container(
                                  width: SizeConfig.screenHeight * 0.16,
                                  height: SizeConfig.screenHeight * 0.16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(_imageSelection!),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        right: -SizeConfig.screenHeight *
                            0.06 /
                            8, // Adjust the position to be slightly outwards for better UX
                        bottom: 0,
                        child: Container(
                          height: SizeConfig.screenHeight * 0.06,
                          width: SizeConfig.screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: SizeConfig.screenWidth * 0.005,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: pickImage,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: kOrangeColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              AuthInput(
                controller: nameController,
                hintText: 'Enter Your Name',
                obscureText: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              AuthInput(
                controller: emailController,
                hintText: 'Enter Your Email',
                obscureText: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              AuthInput(
                controller: passwordController,
                hintText: 'Enter a Secure Password',
                obscureText: true,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              TermsAndConditionsCheck(toggleCheck: toggleCheck),
              SizedBox(
                height: SizeConfig.screenHeight * 0.028,
              ),
              AuthActionButton(onTap: signUp, text: 'Sign Up'),
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
                height: SizeConfig.screenHeight * 0.016,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.screenWidth * 0.02),
                child: GestureDetector(
                  onTap: googleSignUp,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: kOrangeColor, width: 3),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
