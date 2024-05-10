import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  static const String routeName = '/withdraw';
  final String? poolId;
  final dynamic params;
  const Withdraw({super.key, this.poolId, this.params});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Withdraw"),
    );
  }
}
