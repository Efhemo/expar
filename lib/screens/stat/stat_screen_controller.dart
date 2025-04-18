import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/CategoryExpense.dart';

class StatScreenController extends ChangeNotifier {
  final DatabaseService databaseService;
  final ValueNotifier<String?> selectedMonthYear = ValueNotifier<String?>(null);

  StatScreenController({required this.databaseService}) {
    selectedMonthYear.addListener(_loadCategoryExpenses);
  }

  Stream<List<CategoryExpense>> get categoryExpensesStream {
    return selectedMonthYear.value == null
        ? Stream.value([])
        : databaseService.getCategoryExpensesStream(
            int.parse(selectedMonthYear.value!.split('-')[1]),
            int.parse(selectedMonthYear.value!.split('-')[0]),
          );
  }

  Future<List<String>> getAllMonthYearOptions() async {
    return await databaseService.getAllMonthYearOptions();
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
