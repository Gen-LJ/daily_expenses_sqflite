import 'package:flutter/material.dart';

import '../../database/model/expense_model.dart';



class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    super.key,
    required Future<List<ExpenseModel>> expenseFuture, this.delete,
  }) : _expenseFuture = expenseFuture;

  final Future<List<ExpenseModel>> _expenseFuture;
  final Function(int)? delete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExpenseModel>>(
        future: _expenseFuture,
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<ExpenseModel> expenseList=snapshot.data ?? [];
            return ListView.builder(
                key: const PageStorageKey('expense_list'),
                itemCount: expenseList.length,
                itemBuilder: (context,position) {
                  ExpenseModel expenseModel = expenseList[position];
                  DateTime? time = DateTime.tryParse(expenseModel.time?? '');
                  return Column(
                    children: [
                      if(time!= null)
                        Text('${time.day}/${time.month}/${time.year} ${time.hour}:${time.second}'),
                      Card(
                        child: ListTile(
                          leading: delete == null ?
                              Text('') :
                          IconButton(
                              onPressed: (){
                                if(expenseModel.id != null && delete!= null){
                                  delete!(expenseModel.id!);
                                }
                              },
                              icon: Icon(Icons.delete)),
                          title: Text(expenseModel.name?? ''),
                          subtitle: Text('${expenseModel.cost} Ks'),
                          trailing: Text(expenseModel.category?? ' '),
                        ),
                      ),
                    ],
                  );
                }
            );
          }
          else if(snapshot.hasError){

          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }
    );
  }
}