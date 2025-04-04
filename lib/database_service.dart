import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'model/Expense.dart';
import 'model/Category.dart';

class DatabaseService {
  Isar? isar;

  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ExpenseSchema, CategorySchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Isar getIsar() {
    if (isar == null) {
      throw Exception('Isar has not been initialized. Call initializeIsar() first.');
    }
    return isar!;
  }

  Future<Category?> createCategory(String name) async {
    final newCategory = Category()..name = name;
    final isarInstance = getIsar();
    await isarInstance.writeTxn(() async {
      await isarInstance.categorys.put(newCategory);
    });
    return newCategory;
  }

  Future<Expense?> addExpense(String name, double amount, DateTime date, Category category) async {
    final newExpense = Expense()
      ..name = name
      ..amount = amount
      ..date = date;
    final isarInstance = getIsar();

    await isarInstance.writeTxn(() async {
      await isarInstance.expenses.put(newExpense);
      newExpense.category.value = category;
      await newExpense.category.save();
    });
    return newExpense;
  }

  Future<void> deleteExpense(int id) async {
    final isarInstance = getIsar();
    await isarInstance.writeTxn(() async {
      await isarInstance.expenses.delete(id);
    });
  }

  Future<void> updateExpense(int id, String name, double amount, DateTime date, Category category) async {
    final isarInstance = getIsar();
    await isarInstance.writeTxn(() async {
      final expense = await isarInstance.expenses.get(id);
      if (expense != null) {
        expense.name = name;
        expense.amount = amount;
        expense.date = date;
        expense.category.value = category;
        await isarInstance.expenses.put(expense);
        await expense.category.save();
      }
    });
  }

  Stream<List<Expense>> watchAllExpenses() {
    final isarInstance = getIsar();
    return isarInstance.expenses.where().watch(fireImmediately: true).map((expenses) => expenses.toList());
  }

  Stream<List<Category>> watchAllCategories() {
    final isarInstance = getIsar();
    return isarInstance.categorys.where().watch(fireImmediately: true).map((categories) => categories.toList());
  }

  Future<List<Expense>> getLatestExpenses(int limit) async {
    final isarInstance = getIsar();
    return await isarInstance.expenses.where().sortByDateDesc().limit(limit).findAll();
  }
}
