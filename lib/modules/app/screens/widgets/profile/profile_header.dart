import 'package:flutter/material.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel? user;
  const ProfileHeader({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.22,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            kPrimaryColor,
            Colors.blue.shade900,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.064,
          ),
          Text(
            user?.name ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.008,
          ),
          Text(
            user?.email ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.008,
          ),
          Text(
            UtilFormatter.reverseFormatPhoneNumber(user?.phone ?? '07XXXXXXXX'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.008,
          ),
          const Text(
            'Manage your account settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}