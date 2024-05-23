import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/verify_email.dart';
import 'package:grupchat/modules/auth/screens/screens.signup/add_phone_screen.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_action_button.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_input_field.dart';
import 'package:grupchat/modules/auth/screens/widgets/terms_and_conditions_check.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
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
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Terms Check
  bool isChecked = false;
  void toggleCheck() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    _imageSelection = null;
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
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

  Future<Uint8List?> selectImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      return null;
    }
  }

  void googleSignUp() async {
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
      GoogleSignInAccount? response = await AuthService().signInWithGoogle();

      final userData = {
        'id': supabase.auth.currentUser!.id,
        'email': response!.email,
        'name': response.displayName,
        'profile_img': response.photoUrl,
      };

      await supabase
          .from('users')
          .update(userData)
          .eq('id', supabase.auth.currentUser!.id);

      if (mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, AddPhoneScreen.routeName,
            arguments: response);
        showSnackBar(
            context, "Success! Please Add Your Phone Number To Finish Sign Up");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
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
    if (phoneController.text.isEmpty) {
      showSnackBar(context, 'Phone Number is required');
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
      String phoneNumber =
          UtilFormatter.formatPhoneNumber(phoneController.text.trim());
      //check if account with that phone number exists in the database before proceeding
      final phoneCheckResponse = await supabase
          .from('users')
          .select('id')
          .eq('phone', phoneNumber)
          .maybeSingle();

      if (phoneCheckResponse == null) {
        if (mounted) {
          final res = await supabase.auth.signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

          if (res.user == null) {
            if (mounted) {
              Navigator.pop(context);
              showSnackBar(context, 'Sign Up Failed! Please Retry Later');
              return;
            }
          }

          String? imageUrl;
          if (_imageSelection != null) {
            // Upload image to Supabase storage
            final filePath = '${res.user!.id}/profile.png';
            final uploadResponse = await supabase.storage
                .from('profiles')
                .uploadBinary(filePath, _imageSelection!);

            if (uploadResponse.isNotEmpty) {
              // Get the URL of the uploaded image
              imageUrl =
                  supabase.storage.from('profiles').getPublicUrl(filePath);
            } else {
              // Handle storage upload error
              showSnackBar(context, 'Failed to upload image');
            }
          }

          // Prepare user data
          final userData = {
            'id': res.user!.id,
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'phone': phoneNumber,
            'profile_img': imageUrl ??
                'https://ebplsmqddssernqhxabw.supabase.co/storage/v1/object/public/profiles/default-prof-img.png?t=2024-05-20T18%3A55%3A54.167Z',
            'updated_at': DateTime.now().toIso8601String(),
          };

          // Insert user data into the database
          await supabase.from('users').update(userData).eq('id', res.user!.id);

          if (mounted) {
            Navigator.pop(context);
            Navigator.pushNamed(context, VerifyEmailScreen.routeName);
            showSnackBar(
                context, "Please Check Your Email to Verify Your Account");
          }
        }
      } else if (phoneCheckResponse.isNotEmpty) {
        if (mounted) {
          Navigator.pop(context);
          showSnackBar(context, 'Phone number is already registered');
          return;
        }
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
                  color: Colors.black54,
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
                controller: phoneController,
                hintText: 'Enter your Phone Number',
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
                          "Sign Up With Google",
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
