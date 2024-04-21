import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class TermsAndConditionsCheck extends StatefulWidget {
  final VoidCallback? toggleCheck;
  TermsAndConditionsCheck({
    super.key,
    required this.toggleCheck,
  });

  @override
  State<TermsAndConditionsCheck> createState() =>
      _TermsAndConditionsCheckState();
}

class _TermsAndConditionsCheckState extends State<TermsAndConditionsCheck> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = !isChecked;
                    widget.toggleCheck!();
                  });
                }),
          ),
          const Text.rich(
            TextSpan(text: "I agree to the ", children: [
              TextSpan(
                text: "Terms of Service",
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              TextSpan(text: " and "),
              TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue))
            ]),
          ),
        ],
      ),
    );
  }
}
