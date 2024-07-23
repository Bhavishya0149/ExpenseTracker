import 'dart:ffi';

import 'package:expensetracker/unitexpense.dart';
import 'package:flutter/material.dart';
import 'expenses_list.dart';
import 'new_expense_adder.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List <Entry> _registered = [
    // Entry(title: 'Metro', amount: 68, date: DateTime.now(), category: Category.travel),
    // Entry(title: 'Lunch', amount: 40, date: DateTime.now(), category: Category.food),
    // Entry(title: 'Paper', amount: 35, date: DateTime.now(), category: Category.work),
  ];
  
  void addNewEntry(String title, DateTime now, double amt, Category cat){
    setState(() {
      _registered.add(Entry(title: title, amount: amt, date: now, category: cat));
    });
  }

  void showExpenseAdderScreen(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (ctx){
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
        child: ExpenseAdder(addExpenseToList:addNewEntry));
    });
  }

  void removeFromList(Entry obj){
    final idx = _registered.indexOf(obj);
    setState(() {
      _registered.remove(obj);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registered.insert(idx, obj);
          });
        }), 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainScreenMessage = const Center(child: Text('No Expenses', style: TextStyle(fontSize: 25),));

    if(_registered.isNotEmpty){
      mainScreenMessage = ExpensesList(removeOnSwipe: removeFromList, toDisplayList: _registered);
    }

    print(_registered);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Expenses', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: showExpenseAdderScreen, 
            icon: const Icon(Icons.add, color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Chart'),
          Expanded(child: mainScreenMessage),
        ],
      ),
    );
  }
}