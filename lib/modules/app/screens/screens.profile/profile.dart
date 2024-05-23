import 'package:flutter/material.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/modules/app/screens/widgets/profile/profile_header.dart';
import 'package:grupchat/modules/app/screens/widgets/profile/settings_tile.dart';
import 'package:grupchat/modules/auth/screens/screens.signup/add_phone_screen.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user =
          await _authService.getUserDetails(supabase.auth.currentUser!.id);
      setState(() {
        _user = user;
      });
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const ProfileHeader(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.02,
            ),
            child: Column(
              children: [
                ProfileSettingsTile(
                  icon: Icons.phone,
                  title: 'Phone Number',
                  subtitle: 'Add/Update your phone number',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AddPhoneScreen.routeName,
                    );
                  },
                ),
                ProfileSettingsTile(
                  icon: Icons.vibration,
                  title: 'Notifications',
                  subtitle: 'Change Notification Preferences',
                  onTap: () {},
                ),
                ProfileSettingsTile(
                  icon: Icons.phone_android_rounded,
                  title: 'Permissions',
                  subtitle: 'View allowed device permissions',
                  onTap: () {},
                ),
                ProfileSettingsTile(
                  icon: Icons.person_3,
                  title: 'Account Preferences',
                  subtitle: 'Change account preferences',
                  onTap: () {},
                ),
                ProfileSettingsTile(
                  icon: Icons.info,
                  title: 'About Grup Chat',
                  subtitle: 'Privacy Policy, Terms of Service',
                  onTap: () {},
                ),
                ProfileSettingsTile(
                  icon: Icons.snowshoeing_rounded,
                  title: 'Log Out',
                  subtitle: 'Sign out of your account',
                  onTap: () async {
                    await supabase.auth.signOut();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
