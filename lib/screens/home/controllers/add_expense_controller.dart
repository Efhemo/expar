import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Category.dart';

class AddExpenseController extends ChangeNotifier {
  final DatabaseService databaseService;
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Category? selectedCategory;
  DateTime? selectedDate;

  late final Stream<List<Category>> _categories;
  Stream<List<Category>> get categories => _categories;

  AddExpenseController({required this.databaseService}) {
    _categories = databaseService.watchAllCategories();
  }

  void setSelectedCategory(Category category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<Category?> addCategory(String name) async {
    return await databaseService.createCategory(name);
  }

  bool validateExpense() {
    if (expenseNameController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedCategory == null ||
        selectedDate == null) {
      return false;
    }
    return true;
  }

  Future<bool> addExpense(DateTime? date) async {
    if (!validateExpense()) {
      return false;
    }

    final name = expenseNameController.text;
    final amount = double.tryParse(amountController.text.replaceAll(',', '')) ?? 0.0;
    final description = descriptionController.text;

    if (selectedDate == null) {
      return false;
    }

    await databaseService.addExpense(
      name,
      amount,
      selectedDate!,
      selectedCategory!,
      description,
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
