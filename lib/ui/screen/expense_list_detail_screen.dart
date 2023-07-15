import 'package:daily_expense/ui/widget/expense_list_detail_widget.dart';
import 'package:daily_expense/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../database/model/expense_model.dart';

class ExpenseListDetailScreen extends StatefulWidget {
   const ExpenseListDetailScreen({Key? key, required this.todayCostFuture, required this.todayExpenseFuture, required this.date}) : super(key: key);

  final Future<Map<String, dynamic>> todayCostFuture;
  final Future<List<ExpenseModel>> todayExpenseFuture;
  final String date;

  @override
  State<ExpenseListDetailScreen> createState() => _ExpenseListDetailScreenState();
}

class _ExpenseListDetailScreenState extends State<ExpenseListDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('${widget.date} ${widget.date==todayDate()? '(Today)': ''}')
      ),
      body: ExpenseListDetailWidget(
        todayCostFuture: widget.todayCostFuture,
        todayExpenseFuture: widget.todayExpenseFuture,
      ),
    );
  }
}
