import 'package:flutter/material.dart';

class Deposit extends StatelessWidget {
  static const String routeName = '/deposit';
  final String? poolId;
  final dynamic params;
  const Deposit({super.key, this.poolId, this.params});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Deposit"),
    );
  }
}
