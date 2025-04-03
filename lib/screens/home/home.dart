import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/widgets/empty_expense.dart';
import 'package:myapp/widgets/home_stat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/app_bar_icon.svg',
          height: 30,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(children: [HomeStat(), EmptyExpense()]),
    );
  }
}
