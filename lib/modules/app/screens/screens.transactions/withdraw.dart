import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/models/withdraw_request.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

class Withdraw extends StatefulWidget {
  static const String routeName = '/withdraw';
  final String? poolId;
  final dynamic params;

  const Withdraw({Key? key, this.poolId, this.params}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final DataService _dataService = DataService();
  final TextEditingController _amountController = TextEditingController();
  List<PoolListItem> _pools = [];
  List<Contact> _contacts = [];
  PoolListItem? _selectedPool;
  Contact? _selectedContact;
  int _currentStep = 0;
  bool _isLoadingPools = false;

  @override
  void initState() {
    super.initState();
    _loadPools();
  }

  Future<void> _loadContacts() async {
    try {
      final dynamic contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      if (contacts is List<Contact>) {
        setState(() {
          _contacts = contacts;
        });
      } else {
        throw Exception('Failed to retrieve contacts');
      }
    } catch (e) {
      if (mounted) showSnackBar(context, 'Failed to load contacts: $e');
    }
  }

  Future<void> _loadPools() async {
    try {
      setState(() {
        _isLoadingPools = true;
      });
      _pools = await _dataService.getPools();
      if (widget.poolId != null) {
        _selectedPool = _pools.firstWhere(
          (pool) => pool.poolId == widget.poolId,
        );
        if (_selectedPool != null) {
          await _loadContacts();
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

  String _calculateBalance(PoolListItem pool) {
    return (pool.insights.totalDeposits - pool.insights.totalWithdrawals)
        .toString();
  }

  void _onStepContinue() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _withdraw();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _withdraw() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    try {
      if (_selectedPool == null) {
        showSnackBar(context, 'Please Select A Pool Source');
        return;
      }

      if (_selectedContact == null) {
        showSnackBar(context, 'Please Select A Recipient');
        return;
      }

      if (_amountController.text.isEmpty) {
        showSnackBar(context, 'Please Enter An Amount');
        return;
      }

      if (double.parse(_amountController.text) >
          double.parse(_calculateBalance(_selectedPool!))) {
        showSnackBar(context, 'Insufficient Balance');
        return;
      }

      final request = WithdrawRequest(
        poolId: _selectedPool!.poolId,
        amount: double.parse(_amountController.text),
        phone: _selectedContact!.phones.first.number,
      );

      await _dataService.withdrawFromPool(_selectedPool!.poolId, request);
      if (mounted) {
        Navigator.of(context).pop();
        showSnackBar(context, 'Approvals Requested Successfully');
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        showSnackBar(
            context, 'Failed To Request Withdrawal, Please Try Again Later');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps: [
          Step(
            title: const Text('Select Pool'),
            content: _isLoadingPools
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<PoolListItem>(
                      value: _selectedPool,
                      items: _pools
                          .map((pool) => DropdownMenuItem(
                                value: pool,
                                child: Text(pool.name),
                              ))
                          .toList(),
                      onChanged: (selectedPool) async {
                        setState(() {
                          _selectedPool = selectedPool;
                        });

                        final contactsPermission =
                            await FlutterContacts.requestPermission();
                        if (contactsPermission) {
                          await _loadContacts();
                        } else {
                          await FlutterContacts.requestPermission();
                          if (mounted) {
                            showSnackBar(context,
                                'Please enable contacts permission to continue.');
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Pool',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
          ),
          Step(
            title: const Text('Select Recipient'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Contact>(
                items: _contacts
                    .map((contact) => DropdownMenuItem(
                          value: contact,
                          child: Text(contact.displayName),
                        ))
                    .toList(),
                onChanged: (selectedContact) {
                  setState(() {
                    _selectedContact = selectedContact;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Recipient',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Enter Amount'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.012),
                  child: Row(
                    children: [
                      Text(
                        "Available Balance: ${_selectedPool != null ? _calculateBalance(_selectedPool!) : '0'}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Confirm Withdrawal Request'),
            content: Column(
              children: [
                if (_selectedPool != null &&
                    _selectedPool!.numberOfMembers != 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Randomly selected pool members will receive approval request, do you wish to proceed?',
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 12),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Source Pool: ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text('${_selectedPool?.name}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Pool Balance: ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(_selectedPool != null
                                ? _calculateBalance(_selectedPool!)
                                : '0'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Recipient: ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(_selectedContact?.phones.first.number ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Amount: ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(_amountController.text),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
