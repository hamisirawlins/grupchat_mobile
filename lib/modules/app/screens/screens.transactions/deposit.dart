import 'package:flutter/material.dart';

class Deposit extends StatelessWidget {
  static const String routeName = '/deposit';
  final String poolId;
  const Deposit({super.key, required this.poolId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Deposit"),
    );
  }
}
