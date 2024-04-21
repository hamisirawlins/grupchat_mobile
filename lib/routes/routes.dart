import 'package:flutter/material.dart';
import 'package:grupchat/common/widgets/navbar.dart';
import 'package:grupchat/features/auth/screens/screens.forgot_password/forgot_password_screen.dart';
import 'package:grupchat/features/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/features/auth/screens/screens.onboarding/success_screen.dart';
import 'package:grupchat/features/auth/screens/screens.onboarding/verify_email.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeView.routeName: (context) => const HomeView(),
  LoginAndRegisterView.routeName: (context) => const LoginAndRegisterView(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(), 
};
