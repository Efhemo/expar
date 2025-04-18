import 'package:flutter/material.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/model/Expense.dart';
import 'package:provider/provider.dart';

import 'controllers/home_controller.dart';
import 'expense_item.dart';

class AllAvailableExpense extends StatelessWidget {
  const AllAvailableExpense({super.key});

  void _onDismissed(BuildContext context, int index, List expenses) async {
    final databaseService = Provider.of<DatabaseService>(
      context,
      listen: false,
    );
    await databaseService.deleteExpense(expenses[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) =>
              HomeController(databaseService: context.read<DatabaseService>()),
      child: Consumer<HomeController>(
        builder: (context, homeController, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('All Expenses')),
            body: StreamBuilder<List<Expense>>(
              stream: homeController.allExpenses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final expenses = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ExpenseItem(
                        expense: expense,
                        index: index,
                        onDismissed:
                            (index) => _onDismissed(context, index, expenses),
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
