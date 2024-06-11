import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_create.dart';
import 'package:grupchat/components/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/components/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

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
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Create A New Pool',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              const Text('Name:',
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
              SizedBox(height: SizeConfig.screenHeight * 0.008),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "The Pool's Name",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 32),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "A Short Description",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 32),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              const Text('Target Amount:', style: TextStyle(fontSize: 20)),
              SizedBox(height: SizeConfig.screenHeight * 0.024),
              TextField(
                keyboardType: TextInputType.number,
                controller: _targetAmountController,
                decoration: const InputDecoration(
                  labelText: "Target Amount",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 32),
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
              SizedBox(height: SizeConfig.screenHeight * 0.048),
              Center(
                child: NonBorderedButton(
                  onTap: _createPool,
                  text: "Create Pool",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
