import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Category.dart';

class AddExpenseController extends ChangeNotifier {
  final DatabaseService databaseService;
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Category? selectedCategory;
  final List<Category> defaultCategories = [
    Category()..name = 'Groceries',
    Category()..name = 'Transportation',
  ];

  AddExpenseController({required this.databaseService});

  Future<List<Category>> getCategories() async {
    final categoriesFromDatabase =
        await databaseService.watchAllCategories().first;
    final allCategories = [...defaultCategories, ...categoriesFromDatabase];
    return allCategories;
  }

  void setSelectedCategory(Category category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<Category?> addCategory(String name) async {
    return await databaseService.createCategory(name);
  }

  bool validateExpense() {
    if (expenseNameController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedCategory == null) {
      return false;
    }
    return true;
  }

  Future<bool> addExpense() async {
    if (!validateExpense()) {
      return false;
    }

    final name = expenseNameController.text;
    final amount = double.tryParse(amountController.text) ?? 0.0;

    await databaseService.addExpense(
      name,
      amount,
      DateTime.now(),
      selectedCategory!,
    );
    return true;
  }

  @override
  void dispose() {
    expenseNameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
