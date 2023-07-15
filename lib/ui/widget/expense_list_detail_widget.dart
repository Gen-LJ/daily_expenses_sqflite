import 'package:flutter/material.dart';

import '../../database/model/expense_model.dart';
import 'expense_list_widget.dart';
import 'expense_total_cost_widget.dart';

class ExpenseListDetailWidget extends StatelessWidget {
  const ExpenseListDetailWidget({
    super.key,
    required Future<Map<String, dynamic>> todayCostFuture,
    required Future<List<ExpenseModel>> todayExpenseFuture, this.delete,
  }) : _todayCostFuture = todayCostFuture, _todayExpenseFuture = todayExpenseFuture;

  final Future<Map<String, dynamic>> _todayCostFuture;
  final Future<List<ExpenseModel>> _todayExpenseFuture;
  final Function(int)? delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseTotalCost(todayCostFuture: _todayCostFuture),
        const Divider(),
        Expanded(child: ExpenseListWidget(expenseFuture: _todayExpenseFuture,delete: delete)),
      ],
    );
  }
}