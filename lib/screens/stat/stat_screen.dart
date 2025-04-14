import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the pie chart
    final dataMap = <String, double>{
      "Health": 26,
      "Transportation": 24,
      "Gifts": 19,
      "Personal": 16,
      "Groceries": 15,
    };

    final colorList = <Color>[
      const Color(0xFFBA90CA),
      const Color(0xFF7FB5FF),
      const Color(0xFF90EE90),
      const Color(0xFFF4D35E),
      const Color(0xFFE28485),
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Stats',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text("Jan 2025", style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_drop_down),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "\$300.00",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Total 5 expenses",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            PieChart(
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
        ),
      ),
    );
  }
}
