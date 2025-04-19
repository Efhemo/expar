import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/dashboard.dart';
import 'package:myapp/screens/home/add_expense.dart';
import 'package:myapp/screens/home/controllers/home_controller.dart';
import 'package:myapp/screens/stat/stat_screen_controller.dart';
import 'package:myapp/screens/successful_page.dart';
import 'package:myapp/utils/palette.dart';
import 'package:provider/provider.dart';

import 'data/database_service.dart';
import 'screens/home/all_available_expense.dart';
import 'screens/home/controllers/all_available_expense_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.initializeObjectBox();

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) => databaseService),
        ChangeNotifierProvider(
          create:
              (context) =>
                  StatScreenController(databaseService: databaseService),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(databaseService: databaseService),
        ),
        ChangeNotifierProvider(
          create:
              (context) => AllAvailableExpenseController(
                databaseService: databaseService,
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
            return const AddExpenseScreen();
          },
        ),
        GoRoute(
          path: 'allExpense',
          builder: (BuildContext context, GoRouterState state) {
            return const AllAvailableExpense();
          },
        ),
        GoRoute(
          path: 'successful',
          builder: (BuildContext context, GoRouterState state) {
            return const SuccessfulPage();
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
