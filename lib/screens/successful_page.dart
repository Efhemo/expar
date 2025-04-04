import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/widgets/custom_button.dart';
import 'package:myapp/widgets/custom_text_button.dart';

class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Added Successfully',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have successfully added an expense',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Return to dashboard',
              onPressed: () {
                context.go('/');
              },
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              text: 'Add another expense',
              onPressed: () {
                context.go('/addExpense');
              },
            ),
          ],
        ),
      ),
    );
  }
}
