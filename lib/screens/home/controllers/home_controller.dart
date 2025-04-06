import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Expense.dart';

class HomeController extends ChangeNotifier {
  final DatabaseService databaseService;

  HomeController({required this.databaseService}) {
    _latestExpenses = databaseService.watchLatestExpenses(7);
  }

  late final Stream<List<Expense>> _latestExpenses;
  Stream<List<Expense>> get latestExpenses => _latestExpenses;
}
