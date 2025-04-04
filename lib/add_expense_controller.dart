import 'package:flutter/material.dart';
import 'package:myapp/database_service.dart';
import 'package:myapp/model/Category.dart';

class AddExpenseController extends ChangeNotifier {
  final DatabaseService databaseService;

  AddExpenseController({required this.databaseService});

  String? expenseName;
  double? amount;
  Category? selectedCategory;

  void setExpenseName(String name) {
    expenseName = name;
    notifyListeners();
  }

  void setAmount(double amount) {
    this.amount = amount;
    notifyListeners();
  }

  void setSelectedCategory(Category category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> addExpense() async {
    if (expenseName == null || amount == null || selectedCategory == null) {
      return;
    }

    await databaseService.addExpense(expenseName!, amount!, DateTime.now(), selectedCategory!);
  }
}
