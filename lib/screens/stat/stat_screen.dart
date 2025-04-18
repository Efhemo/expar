import 'package:flutter/material.dart';
import 'package:myapp/model/CategoryExpense.dart';
import 'package:myapp/screens/stat/stat_screen_controller.dart';
import 'package:myapp/widgets/pie_chart.dart';
import 'package:provider/provider.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Stats',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StatScreenController>(
          builder: (context, controller, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable: controller.selectedMonthYear,
                  builder: (context, selectedMonthYear, child) {
                    return FutureBuilder<List<String>>(
                      future: controller.getAllMonthYearOptions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final monthYearOptions = snapshot.data ?? [];
                          return DropdownButton<String>(
                            value: selectedMonthYear,
                            hint: const Text('Select Month and Year'),
                            items:
                                monthYearOptions.map((String monthYear) {
                                  return DropdownMenuItem<String>(
                                    value: monthYear,
                                    child: Text(monthYear),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              controller.selectedMonthYear.value = newValue;
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                StreamBuilder<List<CategoryExpense>>(
                  stream: controller.categoryExpensesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final categoryExpenses = snapshot.data ?? [];
                      return PieChartWidget(categoryExpenses: categoryExpenses);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
