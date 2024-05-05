import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/screens.pools/create_pool.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/deposit.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/withdraw.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/modules/auth/screens/screens.forgot_password/forgot_password_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/success_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/verify_email.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeView.routeName: (context) => const HomeView(),
  LoginAndRegisterView.routeName: (context) => const LoginAndRegisterView(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CreatePool.routeName: (context) => const CreatePool(),
  PoolDetails.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return PoolDetails(poolId: args);
    }
    throw Exception('Invalid poolId argument');
  },
  Deposit.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return Deposit(poolId: args);
    }
    throw Exception('Invalid poolId argument');
  },
  Withdraw.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return Withdraw(poolId: args);
    }
    throw Exception('Invalid poolId argument');
  },
};
