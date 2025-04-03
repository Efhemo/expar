import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/model/Expense.dart';
import 'package:myapp/screens/home/all_expense.dart';
import 'package:myapp/widgets/empty_expense.dart';
import 'package:myapp/widgets/home_stat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [
    Expense(name: 'Egg & veggies', category: 'Groceries', amount: 20.0),
    Expense(name: 'Bread and butter', category: 'Groceries', amount: 20.0),
    Expense(name: 'Petrol', category: 'Transportation', amount: 20.0),
  ];

  void _onDismissed(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset('assets/app_bar_icon.svg', height: 40),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          HomeStat(),
          expenses.isNotEmpty
              ? AllExpense(expenses: expenses, onDismissed: _onDismissed)
              : EmptyExpense(),
        ],
      ),
    );
  }
}
