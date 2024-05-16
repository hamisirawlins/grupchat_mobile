import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CreatePool extends StatefulWidget {
  static const String routeName = '/create-pool';
  CreatePool({super.key});

  @override
  State<CreatePool> createState() => _CreatePoolState();
}

class _CreatePoolState extends State<CreatePool> {
  DateTime selectedDate = DateTime.now();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();

  Future<void> _createPool() async {
    // Create a new pool
    print({
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'targetAmount': _targetAmountController.text.trim(),
      'endDate': selectedDate.toIso8601String(),
    });
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
              SizedBox(height: SizeConfig.screenHeight * 0.016),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "The Pool's Name",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 24),
                  border: InputBorder.none,
                ),
              ),
              const Text('Description:'),
              SizedBox(height: SizeConfig.screenHeight * 0.016),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Pool Description",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 24),
                  border: InputBorder.none,
                ),
              ),
              const Text('Target Amount:'),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              TextField(
                keyboardType: TextInputType.number,
                controller: _targetAmountController,
                decoration: const InputDecoration(
                  labelText: "Target Amount",
                  labelStyle: TextStyle(color: Colors.black45, fontSize: 24),
                  border: InputBorder.none,
                ),
              ),
              const Text('End Date:'),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'yyyy-MM-dd',
                initialValue: selectedDate.toIso8601String(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'End Date',
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
