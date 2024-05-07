import 'package:flutter/material.dart';

class CreatePool extends StatelessWidget {
  static const String routeName = '/create-pool';
  const CreatePool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Create Pool'),
      ),
    );
  }
}
