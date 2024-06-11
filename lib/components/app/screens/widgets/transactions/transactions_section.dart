import 'package:flutter/material.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/components/app/screens/screens.transactions/transactions.dart';
import 'package:grupchat/components/app/screens/widgets/transactions/transactions_list.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class TransactionSection extends StatelessWidget {
  const TransactionSection({
    super.key,
    required Pool? pool,
    required List<Transaction> transactions,
    required bool isLoading,
  })  : _pool = pool,
        _transactions = transactions,
        _isLoading = isLoading;

  final Pool? _pool;
  final List<Transaction> _transactions;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.004,
              horizontal: SizeConfig.screenWidth * 0.044),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest Transactions",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, SpecifiedTransactionsList.routeName,
                      arguments: _pool!.poolId);
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.01,
              horizontal: SizeConfig.screenWidth * 0.04),
          child: TransactionsList(
              height: SizeConfig.screenHeight * 0.32,
              isLoading: _isLoading,
              transactions: _transactions),
        )
      ],
    );
  }
}