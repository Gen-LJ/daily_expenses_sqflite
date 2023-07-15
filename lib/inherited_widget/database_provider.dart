


import 'package:daily_expense/database/expense_db.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider extends InheritedWidget {
  const DatabaseProvider({required this.expenseDatabaseHelper, super.key, required super.child});
  final ExpenseDatabaseHelper expenseDatabaseHelper;

  static DatabaseProvider of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<DatabaseProvider>())!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }


}