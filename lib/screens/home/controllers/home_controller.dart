import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Expense.dart';

class HomeController extends ChangeNotifier {
  final DatabaseService databaseService;

  final ValueNotifier<String?> selectedMonthYear = ValueNotifier<String?>(null);

  HomeController({required this.databaseService}) {
    _allExpenses = databaseService.watchAllExpenses();
    selectedMonthYear.addListener(_loadExpenses);
  }

  late final Stream<List<Expense>> _allExpenses;
  Stream<List<Expense>> get allExpenses => _allExpenses;

  Future<List<String>> getAllMonthYearOptions() async {
    return await databaseService.getAllMonthYearOptions();
  }

  Future<void> _loadExpenses() async {
    notifyListeners();
  }

  Stream<List<Expense>> get monthYearExpensesStream {
    return selectedMonthYear.value == null
        ? Stream.value([])
        : databaseService.getExpensesStream(
          int.parse(selectedMonthYear.value!.split('-')[1]),
          int.parse(selectedMonthYear.value!.split('-')[0]),
        );
  }

  @override
  void dispose() {
    selectedMonthYear.removeListener(_loadExpenses);
    selectedMonthYear.dispose();
    super.dispose();
  }
}
