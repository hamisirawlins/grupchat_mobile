import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String description;
  final double amount;
  final String type;
  final DateTime date;
  final String id;
  final VoidCallback? onTap;
  const TransactionCard({
    super.key,
    required this.description,
    required this.amount,
    required this.type,
    required this.id,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: type == 'Deposit' ? Colors.green[100] : Colors.red[100],
      child: ListTile(
        leading: type == 'Deposit'
            ? const Icon(Icons.call_made_sharp)
            : const Icon(Icons.call_received_sharp),
        title: Text('Ksh. $amount'),
        subtitle: Text(description),
        trailing: GestureDetector(child: const Icon(Icons.more_vert)),
        onTap: onTap,
      ),
    );
  }
}
