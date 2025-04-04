import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/utils/currency_input_formatter.dart';
import 'package:myapp/utils/palette.dart';
import 'package:myapp/widgets/add_category_text_button.dart';
import 'package:myapp/widgets/custom_button.dart';
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

  final List<String> _categories = [
    'Food',
    'Transportation',
    'Entertainment',
    'Equipment',
  ];

  void _addCategory(String newCategory) {
    setState(() {
      _categories.add(newCategory);
    });
  }

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
          child: SingleChildScrollView(
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
                CustomDropdown<String>.search(
                  hintText: 'Select category',
                  items: _categories,
                  initialItem: _selectedCategory,
                  overlayHeight: 342,
                  decoration: CustomDropdownDecoration(
                    closedFillColor: fillGrey,
                    closedBorderRadius: BorderRadius.circular(8.0),
                    closedBorder: Border.all(color: strokeGrey, width: 1),
                    expandedBorderRadius: BorderRadius.circular(8.0),
                    expandedBorder: Border.all(color: strokeGrey, width: 1),
                  ),
                  onChanged: (value) {
                    log('SearchDropdown onChanged value: $value');
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox.shrink()),
                    AddCategoryTextButton(addCategory: _addCategory),
                  ],
                ),

                const SizedBox(height: 8),
                CustomTextInput(
                  labelText: 'Description (Optional)',
                  hintText: 'Note',
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: 'Add expense report',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        context.go('/successful');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
