import 'package:flutter/material.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/all_transactions.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/specific_transactions.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required Pool? pool,
  }) : _pool = pool;

  final Pool? _pool;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.02,
              horizontal: SizeConfig.screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "March 2024",
                style: TextStyle(fontWeight: FontWeight.w600),
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
          child: Container(
            height: SizeConfig.screenHeight * 0.1,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: SizeConfig.screenHeight * 0.064,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.pexels.com/photos/8539554/pexels-photo-8539554.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.032),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.004),
                          child: Text(
                            "Contributor Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.004),
                          child: Text(
                            "Deposit/Withdrawal",
                            style: TextStyle(color: Colors.green[600]),
                            // TextStyle(color: Colors.red[600]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.004),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  UtilFormatter.formatDateTime(_pool!.endDate)),
                              Text('+' + _pool!.targetAmount.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
