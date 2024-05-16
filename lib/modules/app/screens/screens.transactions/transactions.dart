import 'package:flutter/material.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/modules/app/screens/widgets/transactions/transactions_list.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
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
          : TransactionsList(
              transactions: _transactions, isLoading: _isLoading),
    );
  }
}
