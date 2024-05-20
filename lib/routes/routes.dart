

import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/screens.pools/create_pool.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_members.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/deposit.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/all_transactions.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/transactions.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/withdraw.dart';
import 'package:grupchat/modules/auth/screens/screens.signup/add_phone_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.signup/sign_up_screen_1.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/modules/auth/screens/screens.forgot_password/forgot_password_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/success_screen.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/verify_email.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeView.routeName: (context) => const HomeView(),
  LoginAndRegisterView.routeName: (context) => const LoginAndRegisterView(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  AddPhoneScreen.routeName: (context) => const AddPhoneScreen(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CreatePool.routeName: (context) => CreatePool(),
  TransactionsScreen.routeName: (context) => const TransactionsScreen(),
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
