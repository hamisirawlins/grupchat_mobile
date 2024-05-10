import 'package:flutter/material.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SpecifiedTransactionsList extends StatefulWidget {
  static const String routeName = '/detailed-transactions';
  final String? search;
  final String? poolId;
  final String? userId;

  const SpecifiedTransactionsList(
      {Key? key, this.search, this.poolId, this.userId})
      : super(key: key);

  @override
  _SpecifiedTransactionsListState createState() =>
      _SpecifiedTransactionsListState();
}

class _SpecifiedTransactionsListState extends State<SpecifiedTransactionsList> {
  final DataService _dataService = DataService();
  bool _isLoading = false;
  List<Transaction> _transactions = [];
  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    // Fetch transactions for the search term
    try {
      setState(() {
        _isLoading = true;
      });
      // Fetch transactions
      final transactions =
          await _dataService.getTransactions(poolId: widget.poolId);
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: kPrimaryColor, size: SizeConfig.screenHeight * 0.04),
            )
          : ListView.builder(
              itemCount: _transactions.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                if (_transactions.isEmpty) {
                  return const Center(
                    child: Text('No transactions found.'),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/pool-details');
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: SizeConfig.screenWidth * 0.04),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01,
                                horizontal: SizeConfig.screenWidth * 0.04),
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
                                          image: _isLoading
                                              ? null
                                              : DecorationImage(
                                                  image: NetworkImage(
                                                      _transactions[index]
                                                          .profImage),
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
                                                        0.004),
                                            child: Text(
                                              _transactions[index].initiatorName ?? _transactions[index].email,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeConfig.screenHeight *
                                                        0.004),
                                            child: Text(
                                              _transactions[index].type,
                                              style: TextStyle(
                                                  color: Colors.green[600]),
                                              // TextStyle(color: Colors.red[600]),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeConfig.screenHeight *
                                                        0.004),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(UtilFormatter
                                                    .formatDateTime(
                                                        _transactions[index]
                                                            .createdAt)),
                                                Text('+' +
                                                    _transactions[index]
                                                        .amount
                                                        .toString())
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
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
