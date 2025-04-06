import 'package:myapp/model/Category.dart';
import 'package:myapp/model/Expense.dart';
import 'package:myapp/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

import 'my_objectbox.dart';

class DatabaseService {
  late final Store store;

  Future<void> initializeObjectBox() async {
    final dir = await getApplicationDocumentsDirectory();
    store = await MyObjectBox.create(directory: '${dir.path}/objectbox');
  }

  Future<Category?> createCategory(String name) async {
    final newCategory = Category()..name = name;
    store.runInTransaction(TxMode.write, () {
      store.box<Category>().put(newCategory);
    });
    return newCategory;
  }

  Future<Expense?> addExpense(
    String name,
    double amount,
    DateTime date,
    Category category,
    String? description,
  ) async {
    final newExpense =
        Expense()
          ..name = name
          ..amount = amount
          ..date = date
          ..description = description
          ..category.target = category;

    store.runInTransaction(TxMode.write, () {
      store.box<Expense>().put(newExpense);
    });
    return newExpense;
  }

  Future<void> deleteExpense(int id) async {
    store.runInTransaction(TxMode.write, () {
      store.box<Expense>().remove(id);
    });
  }

  Future<void> updateExpense(
    int id,
    String name,
    double amount,
    DateTime date,
    Category category,
    String? description,
  ) async {
    final expense = store.box<Expense>().get(id);
    if (expense != null) {
      expense.name = name;
      expense.amount = amount;
      expense.date = date;
      expense.description = description;
      expense.category.target = category;
      store.runInTransaction(TxMode.write, () {
        store.box<Expense>().put(expense);
      });
    }
  }

  Stream<List<Expense>> watchAllExpenses() {
    final box = store.box<Expense>();
    final query = box.query();
    return query.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Category>> watchAllCategories() {
    final box = store.box<Category>();
    final query = box.query();
    return query.watch(triggerImmediately: true).map((query) => query.find());
  }

  Future<List<Expense>> getLatestExpenses(int limit) async {
    final box = store.box<Expense>();
    final query =
        box.query().order(Expense_.date, flags: Order.descending).build();
    query.limit = limit;
    return query.find();
  }

  Stream<List<Expense>> watchLatestExpenses(int limit) {
    final box = store.box<Expense>();
    final query = box.query().order(Expense_.date, flags: Order.descending);
    return query.watch(triggerImmediately: true).map((query) {
      query.limit = limit;
      return query.find();
    });
  }
}
