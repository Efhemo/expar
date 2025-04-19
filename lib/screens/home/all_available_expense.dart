import 'package:flutter/material.dart';
import 'package:myapp/model/Expense.dart';
import 'package:myapp/screens/home/controllers/all_available_expense_controller.dart';
import 'package:provider/provider.dart';

import 'expense_item.dart';

class AllAvailableExpense extends StatelessWidget {
  const AllAvailableExpense({super.key});

  void _onDismissed(BuildContext context, int index, List expenses) async {
    final controller = Provider.of<AllAvailableExpenseController>(
      context,
      listen: false,
    );
    await controller.onDismissed(index, expenses);
  }

  @override
  Widget build(BuildContext context) {
    final allAvailableExpenseController =
        Provider.of<AllAvailableExpenseController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('All Expenses')),
      body: StreamBuilder<List<Expense>>(
        stream: allAvailableExpenseController.allExpenses,
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
  }
}
