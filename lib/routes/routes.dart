import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupchat/components/app/screens/screens.pools/create_pool.dart';
import 'package:grupchat/components/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/components/app/screens/screens.pools/pool_members.dart';
import 'package:grupchat/components/app/screens/screens.transactions/deposit.dart';
import 'package:grupchat/components/app/screens/screens.transactions/deposit_processing.dart';
import 'package:grupchat/components/app/screens/screens.transactions/transactions.dart';
import 'package:grupchat/components/app/screens/screens.transactions/withdraw.dart';
import 'package:grupchat/components/auth/screens/screens.login/login_screen.dart';
import 'package:grupchat/components/auth/screens/screens.signup/add_phone_screen.dart';
import 'package:grupchat/components/auth/screens/screens.signup/sign_up_screen.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/components/auth/screens/screens.forgot_password/forgot_password_screen.dart';
import 'package:grupchat/components/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/components/auth/screens/screens.onboarding/success_screen.dart';
import 'package:grupchat/components/auth/screens/screens.onboarding/verify_email.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeView.routeName: (context) => const HomeView(),
  LoginAndRegisterView.routeName: (context) => const LoginAndRegisterView(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  AddPhoneScreen.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is GoogleSignInAccount) {
      return AddPhoneScreen(user: args);
    } else {
      return const AddPhoneScreen();
    }
  },
  VerifyEmailScreen.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return VerifyEmailScreen(email: args);
    }
    throw Exception('Invalid arguments');
  },
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CreatePool.routeName: (context) => CreatePool(),
  DepositProcessing.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return DepositProcessing(poolId: args);
    }
    throw Exception('Invalid arguments');
  },
  SpecifiedTransactionsList.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return SpecifiedTransactionsList(poolId: args);
    }
    throw Exception('Invalid arguments');
  },
  PoolDetails.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return PoolDetails(poolId: args);
    }
    throw Exception('Invalid poolId argument');
  },
  PoolMembers.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return PoolMembers(poolId: args);
    }
    throw Exception('Invalid poolId argument');
  },
  Deposit.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return Deposit(poolId: args);
    } else {
      return Deposit(params: args);
    }
  },
  Withdraw.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      return Withdraw(poolId: args);
    } else {
      return Withdraw(params: args);
    }
  },
};
