import 'package:flutter/material.dart';

class ExpenseTotalCost extends StatelessWidget {
  const ExpenseTotalCost({
    super.key,
    required Future<Map<String, dynamic>> todayCostFuture,
  }) : _todayCostFuture = todayCostFuture;

  final Future<Map<String, dynamic>> _todayCostFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _todayCostFuture,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Text(' Total Cost - ${snapshot.data?['SUM(cost)'] ?? 0} Ks',
              style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold
              ),);
          } 
          else if(snapshot.hasError){
            return const Text("something wrong");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}