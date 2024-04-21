import 'package:flutter/material.dart';

class PoolsListItem extends StatelessWidget {
  const PoolsListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Image.asset('assets/icons/banknote-envelope.png'),
              title: const Text('Pool Name'),
              subtitle: const Text('Ksh. 200.00'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          const LinearProgressIndicator(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            value: 0.8, // Replace with the actual progress value
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }
}
