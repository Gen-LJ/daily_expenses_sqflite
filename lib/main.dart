import 'package:daily_expense/database/expense_db.dart';
import 'package:daily_expense/inherited_widget/database_provider.dart';
import 'package:daily_expense/ui/screen/home.dart';
import 'package:daily_expense/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ExpenseDatabaseHelper expenseDatabaseHelper = ExpenseDatabaseHelper();
  await expenseDatabaseHelper.init();
  runApp( MyApp(expenseDatabaseHelper: expenseDatabaseHelper,));
}

class MyApp extends StatelessWidget {
  final ExpenseDatabaseHelper expenseDatabaseHelper;
  const MyApp({Key? key, required this.expenseDatabaseHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      expenseDatabaseHelper: expenseDatabaseHelper,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed:  Colors.indigo
        ),
        home: MainScreen(),
      ),
    );
  }
}
