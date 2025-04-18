import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/data/database_service.dart';
import 'package:myapp/screens/home/all_expense.dart';
import 'package:myapp/widgets/empty_expense.dart';
import 'package:myapp/widgets/home_stat.dart';
import 'package:provider/provider.dart';

import 'controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDismissed(BuildContext context, int index, List expenses) async {
    final databaseService = Provider.of<DatabaseService>(
      context,
      listen: false,
    );
    await databaseService.deleteExpense(expenses[index].id);
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
      body: ChangeNotifierProvider(
        create:
            (context) => HomeController(
              databaseService: context.read<DatabaseService>(),
            ),
        child: Consumer<HomeController>(
          builder: (context, homeController, _) {
            return StreamBuilder(
              stream: homeController.monthYearExpensesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final expenses = snapshot.data!;
                  return Column(
                    children: [
                      HomeStat(
                        totalAmount: expenses.fold(
                          0.0,
                          (sum, expense) => sum + (expense.amount ?? 0),
                        ),
                      ),
                      expenses.isNotEmpty
                          ? AllExpense(
                            expenses: expenses,
                            onDismissed:
                                (index) =>
                                    _onDismissed(context, index, expenses),
                          )
                          : EmptyExpense(),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
