import 'package:flutter/material.dart';

class AddPhoneScreen extends StatelessWidget {
  static const String routeName = '/add-phone';
  const AddPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add An M-Pesa Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Add your phone number to continue'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-phone-otp');
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
