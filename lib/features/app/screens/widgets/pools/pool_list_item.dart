import 'package:flutter/material.dart';

class PoolsListItem extends StatelessWidget {
  const PoolsListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                'Pool Name',
              ),
              subtitle: Text(
                'Ksh. 200.00',
              ),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          LinearProgressIndicator(
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
