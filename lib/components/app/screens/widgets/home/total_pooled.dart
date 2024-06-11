import 'package:flutter/material.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class TotalPooled extends StatefulWidget {
  const TotalPooled({
    super.key,
  });

  @override
  State<TotalPooled> createState() => _TotalPooledState();
}

class _TotalPooledState extends State<TotalPooled> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final authService = AuthService();
    final user =
        await authService.getUserDetails(supabase.auth.currentUser!.id);
    setState(() {
      _user = user;
    });
  }

  String getFirstName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'USER!';
    }
    return '${fullName.split(' ')[0]}!';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset("assets/images/warrior-shield.png",
                  height: SizeConfig.screenHeight * 0.08)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Hi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                getFirstName(_user?.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
