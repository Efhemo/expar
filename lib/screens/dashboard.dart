import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/stat/stat_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _destinations = [HomeScreen(), StatScreen()];

  final _bottomNavItem = {
    "Dashboard": Iconsax.home,
    "Stats": Iconsax.status_up,
  };

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _destinations),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20.0,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items:
            _bottomNavItem
                .map(
                  (title, icon) => MapEntry(
                    title,
                    BottomNavigationBarItem(icon: Icon(icon), label: title),
                  ),
                )
                .values
                .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
