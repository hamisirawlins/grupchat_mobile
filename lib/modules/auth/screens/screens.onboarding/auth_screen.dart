import 'package:flutter/material.dart';

import '../screens.login/login_screen.dart';
import '../screens.signup/register_screen.dart';

class LoginAndRegisterView extends StatefulWidget {
    static const String routeName = '/auth';
  const LoginAndRegisterView({super.key});

  @override
  State<LoginAndRegisterView> createState() => _LoginAndRegisterViewState();
}

class _LoginAndRegisterViewState extends State<LoginAndRegisterView> {
  bool showLoginScreen = false;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        toggleScreen: toggleScreen,
      );
    } else {
      return RegisterScreen(
        toggleScreen: toggleScreen,
      );
    }
  }
}
