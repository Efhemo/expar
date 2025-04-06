import 'package:objectbox/objectbox.dart';
import 'Category.dart';

@Entity()
class Expense {
  @Id()
  int id = 0;
  String? name;
  double? amount;
  DateTime? date;

  final category = ToOne<Category>();
}
