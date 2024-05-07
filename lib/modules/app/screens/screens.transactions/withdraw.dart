import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  static const String routeName = '/withdraw';
  final String poolId;
  const Withdraw({super.key, required this.poolId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Withdraw"),
    );
  }
}
