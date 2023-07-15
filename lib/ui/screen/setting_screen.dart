
import 'package:daily_expense/inherited_widget/database_provider.dart';
import 'package:daily_expense/ui/widget/expense_total_cost_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../database/model/category_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);


  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late DatabaseProvider databaseProvider;


  @override
  void initState() {
    super.initState();

  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    databaseProvider= DatabaseProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String,double>>(
        future: priceMap(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String,double> priceMap=snapshot.data?? {};
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children :
                      priceMap.entries.map((e) {
                        return ListTile(
                          title: Text(e.key) ,
                          trailing: Text('${e.value.toInt()} ks'),
                        );
                      }).toList()
                    ,
                  ),
                  Divider(), 
                  PieChart(dataMap: priceMap,
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: true ,
                      showChartValuesOutside: false,
                      decimalPlaces: 0,
                    ),)
                ],
              ),
            );

          }
          if(snapshot.hasError){
            return Center(child: Text('Something Wrong'),);
          }
          return Center(child: CircularProgressIndicator.adaptive(),);
        },
      )
    );
  }

  Future<Map<String,double>> priceMap() async{
    Map<String,double> priceMap={};
    List<CategoryModel> uniqueCategoryList = await databaseProvider.expenseDatabaseHelper.getUniqueCategory();
    for (var value in uniqueCategoryList) {
      String category = value.category?? '';
      Map<String,dynamic> totalCostByCategory = await databaseProvider.expenseDatabaseHelper.totalCostByCategory(category);
      double price =double.tryParse(totalCostByCategory['SUM(cost)'].toString())?? 0;
      priceMap[category]=price;
    }
    return priceMap;
  }

}
