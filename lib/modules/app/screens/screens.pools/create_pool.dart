import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_create.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:intl/intl.dart';

class CreatePool extends StatefulWidget {
  static const String routeName = '/create-pool';
  CreatePool({super.key});

  @override
  State<CreatePool> createState() => _CreatePoolState();
}

class _CreatePoolState extends State<CreatePool> {
  final DataService _dataService = DataService();
  DateTime selectedDate = DateTime.now();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();

  Future<void> _createPool() async {
    // Create a new pool
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
      final pool = await _dataService.createPool(PoolCreate(
        name: _nameController.text,
        targetAmount: double.parse(_targetAmountController.text),
        type: "Group",
        description: _descriptionController.text,
        endDate: selectedDate,
      ));
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, 'Success!');
        Navigator.pushNamed(context, PoolDetails.routeName,
            arguments: pool['pool_id']);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curate A New Pool'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name:', style: TextStyle(color: Colors.black87)),
              SizedBox(height: SizeConfig.screenHeight * 0.008),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "The Pool's Name",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 32),
                  border: InputBorder.none,
                ),
              ),
              const Text('Description:'),
              SizedBox(height: SizeConfig.screenHeight * 0.016),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "A Short Description",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 20),
                  border: InputBorder.none,
                ),
              ),
              const Text('Target Amount:'),
              SizedBox(height: SizeConfig.screenHeight * 0.024),
              TextField(
                keyboardType: TextInputType.number,
                controller: _targetAmountController,
                decoration: const InputDecoration(
                  labelText: "Target Amount",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 30),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              const Text('End Date:'),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'yyyy-MM-dd',
                initialValue: selectedDate.toIso8601String(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                decoration: const InputDecoration(
                    labelText: 'End Date',
                    labelStyle: TextStyle(color: Colors.black45, fontSize: 24),
                    border: InputBorder.none,
                    icon: Icon(Icons.event)),
                onChanged: (val) {
                  setState(() {
                    selectedDate = DateTime.parse(val);
                  });
                },
                validator: (val) {
                  return (val == null || val.isEmpty)
                      ? 'Please select a date'
                      : null;
                },
                onSaved: (val) {
                  if (val != null) {
                    selectedDate = DateTime.parse(val);
                  }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Center(
                child: NonBorderedButton(
                  onTap: _createPool,
                  text: "Create Pool",
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
