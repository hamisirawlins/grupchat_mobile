import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/modules/app/screens/widgets/common/search_bar.dart';
import 'package:grupchat/modules/app/screens/widgets/transactions/transactions_list.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PoolsScreen extends StatefulWidget {
  PoolsScreen({super.key});

  @override
  State<PoolsScreen> createState() => _PoolsScreenState();
}

class _PoolsScreenState extends State<PoolsScreen> {
  final DataService _dataService = DataService();
  final TextEditingController _searchController = TextEditingController();
  List<PoolListItem> _pools = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPools();
  }

  Future<void> _loadPools() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final pools = await _dataService.getPools();
      setState(() {
        _pools = pools;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Searchbar(searchController: _searchController),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              _isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: kPrimaryColor,
                      size: SizeConfig.screenHeight * 0.05)
                  : SizedBox(
                      height: SizeConfig.screenHeight * 0.8,
                      child: ListView.builder(
                        itemCount: _pools.isEmpty ? 1 : _pools.length,
                        itemBuilder: (BuildContext context, int position) {
                          if (_pools.isEmpty) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/create-pool');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.016,
                                  ),
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.16,
                                    width: SizeConfig.screenHeight * 0.28,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kSecondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Get Started",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Text(_pools[position].name),
                                  Text(
                                      _pools[position].targetAmount.toString()),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/create-pool');
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Create Pool',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
