import 'package:flutter/material.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required List<Transaction> transactions,
    required bool isLoading,
  })  : _transactions = transactions,
        _isLoading = isLoading;

  final List<Transaction> _transactions;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: kPrimaryColor, size: SizeConfig.screenHeight * 0.04),
          )
        : SizedBox(
            height: SizeConfig.screenHeight * 0.4,
            child: ListView.builder(
              itemCount: _transactions.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                if (_transactions.isEmpty) {
                  return const Center(
                    child: Text('No transactions Made Yet.'),
                  );
                } else {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: SizeConfig.screenWidth * 0.02),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.002,
                              horizontal: SizeConfig.screenWidth * 0.032),
                          child: SizedBox(
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
                                                _transactions[index].profImage),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.032),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.screenHeight *
                                                      0.002),
                                          child: Text(
                                            _transactions[index]
                                                    .initiatorName ??
                                                _transactions[index].email,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.screenHeight *
                                                      0.002),
                                          child: Text(
                                            _transactions[index].type,
                                            style: _transactions[index].type ==
                                                    'Deposit'
                                                ? TextStyle(
                                                    color: Colors.green[600])
                                                : TextStyle(
                                                    color: Colors.red[600]),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.screenHeight *
                                                      0.004),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(UtilFormatter.formatDateTime(
                                                  _transactions[index]
                                                      .createdAt)),
                                              Text(
                                                _transactions[index].type ==
                                                        'Deposit'
                                                    ? '+${_transactions[index].amount}'
                                                    : '-${_transactions[index].amount}',
                                                style: _transactions[index]
                                                            .type ==
                                                        'Deposit'
                                                    ? TextStyle(
                                                        color:
                                                            Colors.green[600])
                                                    : TextStyle(
                                                        color: Colors.red[600]),
                                              )
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
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
  }
}
