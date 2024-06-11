import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kPrimaryColor),
        child: ListTile(
          textColor: Colors.white,
          leading: Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 14),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
