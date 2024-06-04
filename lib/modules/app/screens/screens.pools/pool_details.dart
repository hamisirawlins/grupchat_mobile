import 'package:flutter/material.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/bordered_button.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/deposit.dart';
import 'package:grupchat/modules/app/screens/screens.transactions/withdraw.dart';
import 'package:grupchat/modules/app/screens/widgets/transactions/transactions_section.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PoolDetails extends StatefulWidget {
  static const String routeName = '/pool-details';
  final String poolId;

  const PoolDetails({super.key, required this.poolId});

  @override
  State<PoolDetails> createState() => _PoolDetailsState();
}

class _PoolDetailsState extends State<PoolDetails> {
  final DataService _dataService = DataService();

  Pool? _pool;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  bool _isTransactionsLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPoolDetails();
    _loadPoolTransactions();
  }

  Future<void> _loadPoolTransactions() async {
    try {
      setState(() {
        _isTransactionsLoading = true;
      });

      final transactions = await _dataService.getTransactions(
          poolId: widget.poolId, page: 1, pageSize: 3);
      setState(() {
        _transactions = transactions;
        _isTransactionsLoading = false;
      });
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  Future<void> _loadPoolDetails() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final pool = await _dataService.getPool(widget.poolId);
      setState(() {
        _pool = pool;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  String _getPoolProgressComment(int progress) {
    if (progress <= 1) {
      return 'We are just getting started';
    } else if (progress < 2) {
      return 'We are making progress';
    } else if (progress < 4) {
      return 'We are almost there';
    } else {
      return 'Congratulations! We made it!';
    }
  }

  @override
  Widget build(BuildContext context) {
    int progress = _pool != null
        ? (_pool!.insights.totalDeposits / _pool!.targetAmount * (10 / 4))
            .round()
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pool?.name ?? 'Pool Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pushNamed(context, HomeView.routeName);
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: kPrimaryColor, size: SizeConfig.screenHeight * 0.04),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.032),
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(_getPoolProgressComment(progress),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      '${_pool!.insights.totalDeposits} out of ${_pool!.targetAmount}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            StepProgressIndicator(
                              totalSteps: 4,
                              currentStep: progress,
                              selectedColor: kPrimaryColor,
                              unselectedColor: kSecondaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(Icons.timelapse_outlined),
                                  ),
                                  Text(
                                      'Ends On: ${UtilFormatter.formatDate(_pool!.endDate)}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.016,
                  ),
                  BorderedButton(
                    onTap: () {
                      Navigator.pushNamed(context, Withdraw.routeName,
                          arguments: _pool!.poolId);
                    },
                    text: "Withdraw Now",
                  ),
                  NonBorderedButton(
                    onTap: () {
                      Navigator.pushNamed(context, Deposit.routeName,
                          arguments: _pool!.poolId);
                    },
                    text: "Deposit",
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  TransactionSection(
                    pool: _pool!,
                    transactions: _transactions,
                    isLoading: _isTransactionsLoading,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/pool-members',
                            arguments: _pool!.poolId);
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * 0.064,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.04),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Manage Your Pool Members?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.people_alt_rounded,
                                  color: Colors.white,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
