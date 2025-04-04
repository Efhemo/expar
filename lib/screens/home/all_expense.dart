import 'package:flutter/material.dart';
import 'package:myapp/model/Expense.dart';
import 'package:myapp/screens/home/expense_item.dart';

class AllExpense extends StatelessWidget {
  final List<Expense> expenses;
  final Function(int index) onDismissed;
  const AllExpense({
    Key? key,
    required this.expenses,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expenses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: Text('See all')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseItem(
                  expense: expense,
                  onDismissed: onDismissed,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
