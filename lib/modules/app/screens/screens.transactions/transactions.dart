import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/widgets/transactions/transaction_card.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.grey[300],
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Deposits',
                  ),
                  Tab(
                    text: 'Withdrawals',
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.02),
                  child: ListView(
                    children: [
                      TransactionCard(
                        description: 'Transaction Description',
                        amount: 200.00,
                        date: DateTime.now(),
                        id: 'uuid',
                        type: 'Deposit',
                      ),
                      TransactionCard(
                        description: 'Transaction Description',
                        amount: 200.00,
                        date: DateTime.now(),
                        id: 'uuid',
                        type: 'Withdrawal',
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.02),
                    child: Column(
                      children: [
                        TransactionCard(
                          description: 'Transaction Description',
                          amount: 200.00,
                          date: DateTime.now(),
                          id: 'uuid',
                          type: 'Deposit',
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.02),
                    child: Column(
                      children: [
                        TransactionCard(
                          description: 'Transaction Description',
                          amount: 200.00,
                          date: DateTime.now(),
                          id: 'uuid',
                          type: 'Withdrawal',
                        ),
                      ],
                    )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
