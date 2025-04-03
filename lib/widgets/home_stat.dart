import 'package:flutter/material.dart';

class HomeStat extends StatelessWidget {
  const HomeStat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '\$0.00',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('(0) Expenses report created'),
              ],
            ),
            Row(
              children: const [Text('Jan 2025'), Icon(Icons.arrow_drop_down)],
            ),
          ],
        ),
      ),
    );
  }
}
