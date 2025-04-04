import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/add_expense_controller.dart';
import 'package:myapp/database_service.dart';
import 'package:myapp/model/Category.dart';
import 'package:myapp/utils/currency_input_formatter.dart';
import 'package:myapp/utils/palette.dart';
import 'package:myapp/widgets/add_category_text_button.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Category? _selectedCategory;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    _categories = await databaseService.getIsar().categorys.where().findAll();
    setState(() {});
  }

  void _addCategory(String newCategoryName) async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    final newCategory = await databaseService.createCategory(newCategoryName);
    if (newCategory != null) {
      setState(() {
        _categories.add(newCategory);
      });
    }
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
    return ChangeNotifierProvider(
      create: (context) => AddExpenseController(
        databaseService: Provider.of<DatabaseService>(context, listen: false),
      ),
      child: Scaffold(
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
                    onChanged: (value) => Provider.of<AddExpenseController>(context, listen: false)
                        .setExpenseName(value),
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
                    onChanged: (value) => Provider.of<AddExpenseController>(context, listen: false)
                        .setAmount(double.tryParse(value.replaceAll(',', '')) ?? 0),
                  ),
                  const SizedBox(height: 8),
                  CustomDropdown<Category>.search(
                    hintText: 'Select category',
                    items: _categories,
                    itemAsString: (Category? category) => category?.name ?? '',
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
                        Provider.of<AddExpenseController>(context, listen: false)
                            .setSelectedCategory(value!);
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await Provider.of<AddExpenseController>(context, listen: false).addExpense();
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
      ),
    );
  }
}
