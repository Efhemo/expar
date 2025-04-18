import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Expense.dart';

class AllAvailableExpenseController extends ChangeNotifier {
  final DatabaseService databaseService;
  AllAvailableExpenseController({required this.databaseService});

  Stream<List<Expense>> get allExpenses => databaseService.watchAllExpenses();

  Future<void> onDismissed(int index, List expenses) async {
    await databaseService.deleteExpense(expenses[index].id);
  }
}
