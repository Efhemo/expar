import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/dashboard.dart';
import 'package:myapp/screens/home/add_expense.dart';
import 'package:myapp/screens/successful_page.dart';
import 'package:myapp/utils/palette.dart';
import 'package:provider/provider.dart';
import 'database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.initializeIsar();

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(
          create: (_) => databaseService,
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
