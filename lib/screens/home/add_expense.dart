import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/utils/currency_input_formatter.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_dropdown.dart';
import 'package:myapp/widgets/custom_text_input.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;

  final _categories = ['Food', 'Transportation', 'Entertainment'];

  @override
  void dispose() {
    _expenseNameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox.shrink(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Expense',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              CustomTextInput(
                labelText: 'Expense Name',
                hintText: 'Enter expense name',
                controller: _expenseNameController,
              ),
              const SizedBox(height: 8),
              CustomTextInput(
                labelText: 'Amount',
                hintText: '1,000.00',
                controller: _amountController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.attach_money),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
              ),
              const SizedBox(height: 8),
              CustomDropdown<String>(
                labelText: 'Category',
                value: _selectedCategory,
                items: _categories.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomTextInput(
                labelText: 'Description (Optional)',
                hintText: 'Note',
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: 'Add expense report',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
