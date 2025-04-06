import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  @Id()
  int id = 0;
  String? name;

  @override
  String toString() {
    return name ?? "";
  }
}
