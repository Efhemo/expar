import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Expense.dart';

class HomeController extends ChangeNotifier {
  final DatabaseService databaseService;

  final ValueNotifier<String?> selectedMonthYear = ValueNotifier<String?>(null);
  List<String> monthYearOptions = [];

  HomeController({required this.databaseService}) {
    _allExpenses = databaseService.watchAllExpenses();
    selectedMonthYear.addListener(_loadExpenses);
    _allExpenses.listen((_) {
      _loadMonthYearOptions();
    });
  }

  late final Stream<List<Expense>> _allExpenses;
  Stream<List<Expense>> get allExpenses => _allExpenses;

  Future<void> _loadMonthYearOptions() async {
    monthYearOptions = await databaseService.getAllMonthYearOptions();
    if (monthYearOptions.isNotEmpty && selectedMonthYear.value == null) {
      selectedMonthYear.value = monthYearOptions.first;
    }
    notifyListeners();
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

  Future<void> onDismissed(int index, List expenses) async {
    if (expenses.length < 2) {
      selectedMonthYear.value = null;
    }
    await databaseService.deleteExpense(expenses[index].id);
  }

  @override
  void dispose() {
    selectedMonthYear.removeListener(_loadExpenses);
    selectedMonthYear.dispose();
    super.dispose();
  }
}
