import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/database_service.dart';
import 'package:myapp/model/Expense.dart';
import 'package:myapp/screens/home/all_expense.dart';
import 'package:myapp/widgets/empty_expense.dart';
import 'package:myapp/widgets/home_stat.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    _expenses = await databaseService.getLatestExpenses(7);
    setState(() {});
  }

  void _onDismissed(int index) async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    await databaseService.deleteExpense(_expenses[index].id);
    _loadExpenses();
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
          _expenses.isNotEmpty
              ? AllExpense(expenses: _expenses, onDismissed: _onDismissed)
              : EmptyExpense(),
        ],
      ),
    );
  }
}
