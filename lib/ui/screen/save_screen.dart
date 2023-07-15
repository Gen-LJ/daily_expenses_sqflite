
import 'package:daily_expense/inherited_widget/database_provider.dart';
import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({Key? key}) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late DatabaseProvider databaseProvider;
  final GlobalKey<FormState> _formKey = GlobalKey();
   String? _name,_cost,_category;


   @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    databaseProvider = DatabaseProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (name){
                  if(name == null || name.isEmpty){
                    return 'Please Enter your Name';
                  }
                },
                onSaved: (name){
                  _name = name;
                },
                decoration: const InputDecoration(
                  label: Text('Name')),
              ),
              TextFormField(
                validator: (cost){
                  if(cost == null || cost.isEmpty){
                    return 'Please Enter your Cost';
                  }
                },
                onSaved: (cost){
                  _cost = cost;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Cost')),
              ),
              TextFormField(
                  validator: (category){
                    if(category == null || category.isEmpty){
                      return 'Please Enter your Cotegory';
                    }
                  },
                  onSaved: (category){
                    _category = category;
                  },
                decoration: const InputDecoration(
                  label: Text('Category'))
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                      _formKey.currentState?.save();
                      if(_formKey.currentState?.validate()?? false){
                        DateTime now= DateTime.now();
                        int? cost =int.tryParse(_cost!);
                        if(cost != null) {
                          databaseProvider.expenseDatabaseHelper.insertExpense(name: _name!, cost: cost!, time: now.toString(), category: _category!);
                          if(mounted){
                            Navigator.pop(context,'inserted');
                            ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Successfully saved')));
                          }
                        }
                      }
                      },
                      child: const Text('Save')),
                  SizedBox(width: 8,),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('Cancel'))
                ],
              ),
            ],
          ),
        )
    );
  }
}
