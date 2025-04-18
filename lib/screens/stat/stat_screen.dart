import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/CategoryExpense.dart';
import 'package:myapp/screens/stat/stat_screen_controller.dart';
import 'package:pie_chart/pie_chart.dart';
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
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final categoryExpenses = snapshot.data ?? [];
                      return _buildPieChart(categoryExpenses, context);
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

  Widget _buildPieChart(
    List<CategoryExpense> categoryExpenses,
    BuildContext context,
  ) {
    // Calculate total expense amount and count
    double totalAmount = 0;
    int totalExpenses = 0;
    for (final categoryExpense in categoryExpenses) {
      totalAmount += categoryExpense.amount;
      totalExpenses++;
    }

    // Sort categories by amount in descending order
    categoryExpenses.sort((a, b) => b.amount.compareTo(a.amount));

    // Take the top 5 categories
    final top5Categories = categoryExpenses.take(5).toList();

    // Calculate the amount for "others"
    double othersAmount = 0;
    if (categoryExpenses.length > 5) {
      othersAmount = categoryExpenses
          .skip(5)
          .fold(0, (sum, item) => sum + item.amount);
    }

    // Create the dataMap for the pie chart
    final dataMap = <String, double>{};
    for (final categoryExpense in top5Categories) {
      dataMap[categoryExpense.category] = categoryExpense.amount;
    }
    if (othersAmount > 0) {
      dataMap['Others'] = othersAmount;
    }

    final colorList = <Color>[
      const Color(0xFFBA90CA),
      const Color(0xFF7FB5FF),
      const Color(0xFF90EE90),
      const Color(0xFFF4D35E),
      const Color(0xFFE28485),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          NumberFormat.currency(locale: 'en_US').format(totalAmount),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "Total $totalExpenses expenses",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 32),
        categoryExpenses.isEmpty
            ? const Text('No data available')
            : dataMap.isEmpty
            ? const Text('No data available')
            : PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              colorList: colorList,
              chartRadius: MediaQuery.of(context).size.width / 1.5,
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              centerText: '',
              legendOptions: const LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
            ),
      ],
    );
  }
}
