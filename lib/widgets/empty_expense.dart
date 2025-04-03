import 'package:flutter/material.dart';
import 'package:myapp/utils/palette.dart';

class EmptyExpense extends StatelessWidget {
  const EmptyExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No expense report found!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text('Create an expense report to get started'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Add expense report',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
