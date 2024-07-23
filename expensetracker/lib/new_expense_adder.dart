// import 'dart:ffi';

import 'package:expensetracker/unitexpense.dart';
import 'package:flutter/material.dart';
import 'unitexpense.dart';

class ExpenseAdder extends StatefulWidget {
  final Function(String, DateTime, double, Category) addExpenseToList;
  
  const ExpenseAdder({required this.addExpenseToList, super.key});

  @override
  State<ExpenseAdder> createState() => _ExpenseAdderState();
}

class _ExpenseAdderState extends State<ExpenseAdder> {
  Category selectedCat = Category.leisure;

  // String _enteredTitle = '';
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate = DateTime.now();

  void openDatePicker() async {
    final DateTime now = DateTime.now();
    final first_date = DateTime(now.year - 1, now.month, now.day);
    final last_date = now;
    
    DateTime? temp = await showDatePicker(context: context, 
      initialDate: DateTime.now(),
      firstDate: first_date, 
      lastDate: last_date
    );
    setState(() {
      selectedDate = temp;
    });
  }

  void dispose(){
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void adderHelper(){
    final title = _titleController.text;
    final double? amt = double.tryParse(_amountController.text);

    print(title);
    print(amt);
    print(selectedDate);

    if(title.trim() == '' || amt == null || selectedDate == null){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Check and fill all fields correctly'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(ctx);}, child: const Text('Okay'),)
        ],
      ));
      return;
    }
    if(amt < 0){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Amount cannot be negative'),
        content: const Text('Enter correct amount'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(ctx);}, child: const Text('Okay'),)
        ],
      ));
      return;
    }
    widget.addExpenseToList(title, selectedDate!, amt, selectedCat);
    // dispose();
    Navigator.pop(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Expense title')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _amountController,
                  // maxLength: 50,
                  decoration: const InputDecoration(
                    prefix: Text('₹ '),
                    label: Text('Expense amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (selectedDate != null) ? Text(formatter.format(selectedDate!)) : const Text('No date selected'),
                    const SizedBox(width: 5,),
                    IconButton(
                      onPressed: () {
                        openDatePicker();
                      }, 
                      icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16
          ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: selectedCat,
                items: Category.values.map(
                  (category){
                      // print(value);
                     return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  print(selectedCat);
                  if(value == null) return;
                  setState(() {
                    selectedCat = value;
                  });                
                  print(value);
                }
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  adderHelper();
                }, 
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}