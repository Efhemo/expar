import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Category.dart';
import 'package:myapp/utils/currency_input_formatter.dart';
import 'package:myapp/widgets/add_category_text_button.dart';
import 'package:myapp/widgets/category_dropdown.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

import 'controllers/add_expense_controller.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => AddExpenseController(
            databaseService: context.read<DatabaseService>(),
          ),
      child: Consumer<AddExpenseController>(
        builder: (context, controller, _) {
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextInput(
                        labelText: 'Expense Name',
                        hintText: 'Enter expense name',
                        controller: controller.expenseNameController,
                        errorText:
                            controller.expenseNameController.text.isEmpty
                                ? 'Expense name is required'
                                : null,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        labelText: 'Amount',
                        hintText: '1,000.00',
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.attach_money),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        errorText:
                            controller.amountController.text.isEmpty
                                ? 'Amount is required'
                                : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Category',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      StreamBuilder<List<Category>>(
                        stream: controller.categories,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final categories = snapshot.data!;
                            return CategoryDropdown(
                              categories: categories,
                              onChanged: (value) {
                                controller.setSelectedCategory(value!);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox.shrink()),
                          AddCategoryTextButton(
                            addCategory: (String newCategoryName) async {
                              await controller.addCategory(newCategoryName);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        labelText: 'Description (Optional)',
                        hintText: 'Note',
                        controller: controller.descriptionController,
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
                              if (controller.selectedCategory == null) {
                                Fluttertoast.showToast(
                                  msg: 'Please select a category',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                                return;
                              }
                              final success = await controller.addExpense();
                              if (success) {
                                context.go('/successful');
                              }
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
        },
      ),
    );
  }
}
