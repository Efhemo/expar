import 'package:isar/isar.dart';

part 'Category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;
  String? name;
}
