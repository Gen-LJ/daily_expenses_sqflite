
import 'package:daily_expense/ui/screen/all_expense_list_screen.dart';
import 'package:daily_expense/ui/screen/setting_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _body = const Home();
   late List<Widget> _bodyList;
   int _selectedNavigationIndex=0;

   @override
  void initState() {
    super.initState();
    _bodyList=[
      const Home(),
    const AllExpenseList(),
    const SettingScreen()];


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavigationIndex,
        onDestinationSelected: (index){
          setState(() {
            _body=_bodyList[index];
            _selectedNavigationIndex=index;
          });

        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: 'All Expense'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
