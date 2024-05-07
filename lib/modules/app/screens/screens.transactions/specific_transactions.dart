import 'package:flutter/material.dart';

class SpecifiedTransactionsList extends StatelessWidget {
    static const String routeName = '/detailed-transactions';
    final String search;
  const SpecifiedTransactionsList({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: Center(
        child: Text("Transactions for $search"),
      ),
    );
  }
}
