import 'package:flutter/material.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/deposit_request.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/components/app/screens/screens.transactions/deposit_processing.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

class Deposit extends StatefulWidget {
  static const String routeName = '/deposit';
  final String? poolId;
  final dynamic params;

  const Deposit({Key? key, this.poolId, this.params}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final DataService _dataService = DataService();
  final AuthService _authService = AuthService();
  final TextEditingController _amountController = TextEditingController();

  List<PoolListItem> _pools = [];
  PoolListItem? _selectedPool;
  bool _isLoadingPools = false;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadPools();
    _loadUserDetails();
  }

  Future<void> _loadPools() async {
    try {
      setState(() {
        _isLoadingPools = true;
      });
      _pools = await _dataService.getPools(1, 40);
      if (widget.poolId != null) {
        for (var pool in _pools) {
          if (pool.poolId == widget.poolId) {
            _selectedPool = pool;
            break;
          }
        }
      }
    } catch (e) {
      showSnackBar(context, 'Failed to load pools: $e');
    } finally {
      setState(() {
        _isLoadingPools = false;
      });
    }
  }

  Future<void> _loadUserDetails() async {
    try {
      final String userId = supabase.auth.currentUser!.id;
      final UserModel user = await _authService.getUserDetails(userId);
      _user = user;
    } catch (e) {
      if (mounted) showSnackBar(context, 'Failed to load user details: $e');
    }
  }

  Future<void> _performDeposit() async {
    try {
      if (_selectedPool == null) {
        showSnackBar(context, 'Please select a pool');
        return;
      }

      if (_amountController.text.isEmpty) {
        showSnackBar(context, 'Please enter the amount');
        return;
      }

      _dataService.depositToPool(
          _selectedPool!.poolId,
          DepositRequest(
            poolId: _selectedPool!.poolId,
            amount: double.parse(_amountController.text),
            phone: _user!.phone ?? '',
          ));
      showSnackBar(context, 'Deposit Requested Successfully');
      Navigator.pushNamed(context, DepositProcessing.routeName,
          arguments: _selectedPool!.poolId);
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, 'Failed to deposit: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLoadingPools)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_pools.isNotEmpty) ...[
              DropdownButtonFormField<PoolListItem>(
                value: _selectedPool,
                items: _pools
                    .map((pool) => DropdownMenuItem(
                          value: pool,
                          child: Text(pool.name),
                        ))
                    .toList(),
                onChanged: (selectedPool) {
                  setState(() {
                    _selectedPool = selectedPool;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Select Pool',
                    labelStyle: const TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: kPrimaryColor),
                    )),
              ),
              const SizedBox(height: 16.0),
            ] else ...[
              const Text(
                  'No Pools Available, \nKindly Create One To Pool Your Money'),
              const SizedBox(height: 16.0),
            ],
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: const TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: kPrimaryColor),
                  )),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _performDeposit,
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.016,
                      horizontal: SizeConfig.screenWidth * 0.04),
                  child: const Center(
                    child: Text(
                      "Deposit",
                      style: TextStyle(color: Colors.white),
                    ),
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
