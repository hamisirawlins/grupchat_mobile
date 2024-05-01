import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/colors.dart';

class AuthInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const AuthInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: kSecondaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
