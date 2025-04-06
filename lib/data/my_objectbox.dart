import 'package:myapp/objectbox.g.dart';

class MyObjectBox {
  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Store> create({String? directory}) async {
    final store = Store(getObjectBoxModel(), directory: directory);
    return store;
  }
}
