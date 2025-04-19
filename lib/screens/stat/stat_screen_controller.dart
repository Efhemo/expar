import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/CategoryExpense.dart';
import 'package:myapp/model/Expense.dart';

class StatScreenController extends ChangeNotifier {
  final DatabaseService databaseService;
  final ValueNotifier<String?> selectedMonthYear = ValueNotifier<String?>(null);
  List<String> monthYearOptions = [];

  late final Stream<List<Expense>> _allExpenses;
  Stream<List<Expense>> get allExpenses => _allExpenses;

  StatScreenController({required this.databaseService}) {
    _allExpenses = databaseService.watchAllExpenses();
    selectedMonthYear.addListener(_loadCategoryExpenses);
    _allExpenses.listen((_) {
      getAllMonthYearOptions();
    });
  }

  Stream<List<CategoryExpense>> get categoryExpensesStream {
    return selectedMonthYear.value == null
        ? Stream.value([])
        : databaseService.getCategoryExpensesStream(
          int.parse(selectedMonthYear.value!.split('-')[1]),
          int.parse(selectedMonthYear.value!.split('-')[0]),
        );
  }

  Future<void> getAllMonthYearOptions() async {
    monthYearOptions = await databaseService.getAllMonthYearOptions();
    if (monthYearOptions.isNotEmpty && selectedMonthYear.value == null) {
      selectedMonthYear.value = monthYearOptions.first;
    }
    notifyListeners();
  }

  Future<void> _loadCategoryExpenses() async {
    notifyListeners();
  }

  @override
  void dispose() {
    selectedMonthYear.removeListener(_loadCategoryExpenses);
    selectedMonthYear.dispose();
    super.dispose();
  }
}
