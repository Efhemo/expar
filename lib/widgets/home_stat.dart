import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/home/controllers/home_controller.dart';
import 'package:myapp/utils/palette.dart';
import 'package:provider/provider.dart';

class HomeStat extends StatelessWidget {
  final double totalAmount;
  const HomeStat({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor, width: 1),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NumberFormat.currency(locale: 'en_US').format(totalAmount),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Text('(0) Expenses report created'),
              ],
            ),
            ValueListenableBuilder<String?>(
              valueListenable:
                  Provider.of<HomeController>(context).selectedMonthYear,
              builder: (context, selectedMonthYear, child) {
                final homeController = Provider.of<HomeController>(context);
                final monthYearOptions = homeController.monthYearOptions;
                // if (monthYearOptions.isEmpty) {
                //   return const CircularProgressIndicator();
                // }
                return DropdownButton<String>(
                  value: selectedMonthYear,
                  hint: const Text(''),
                  items:
                      monthYearOptions.map((String monthYear) {
                        return DropdownMenuItem<String>(
                          value: monthYear,
                          child: Text(monthYear),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    homeController.selectedMonthYear.value = newValue;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
