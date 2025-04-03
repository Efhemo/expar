import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/dashboard.dart';
import 'package:myapp/screens/home/add_expense.dart';
import 'package:myapp/utils/palette.dart'; // Import the palette.dart file

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Dashboard();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'addExpense',
          builder: (BuildContext context, GoRouterState state) {
            return const AddExpense();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'expar',
      theme: Palette.getTheme(),
    );
  }
}
