import 'package:isar/isar.dart';
import 'Category.dart';

part 'Expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  String? name;
  double? amount;
  DateTime? date;

  final category = IsarLink<Category>();
}
