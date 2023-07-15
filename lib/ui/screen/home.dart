
import 'package:daily_expense/database/model/expense_model.dart';
import 'package:daily_expense/inherited_widget/database_provider.dart';
import 'package:daily_expense/ui/screen/save_screen.dart';
import 'package:daily_expense/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import '../widget/expense_list_detail_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  late Future<List<ExpenseModel>> _todayExpenseFuture;
  late Future<Map<String,dynamic>> _todayCostFuture;
  late DatabaseProvider databaseProvider;

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    databaseProvider = DatabaseProvider.of(context);
    _todayExpenseFuture = databaseProvider.expenseDatabaseHelper.getAllExpenseByDate(todayDate());
    _todayCostFuture = databaseProvider.expenseDatabaseHelper.totalCostOfToday(todayDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Daily Expense(Today ${todayDate()})'),
        centerTitle: true,

      ),
      body: ExpenseListDetailWidget(
          todayCostFuture: _todayCostFuture,
          todayExpenseFuture: _todayExpenseFuture,
      delete: (int position) async{
            databaseProvider.expenseDatabaseHelper.deleteExpenseById(position);
            _refreshScreen();
            },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
          String? dialogResult = await showDialog(
              context: context,
              builder: (context){
            return const AlertDialog(
              title: Text('Enter your expense'),
              content: SaveScreen(),
            );
          });
          if(dialogResult == 'inserted'){
            _refreshScreen();
          }
        },
      ),
    );
  }
  void _refreshScreen(){
    setState(() {
      _todayExpenseFuture = databaseProvider.expenseDatabaseHelper.getAllExpenseByDate(todayDate());
      _todayCostFuture= databaseProvider.expenseDatabaseHelper.totalCostOfToday(todayDate());
    });
  }
}






