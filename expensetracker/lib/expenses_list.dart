import 'package:flutter/material.dart';
import 'unitexpense.dart';

class ExpensesList extends StatelessWidget {
  final List <Entry> toDisplayList;
  final Function(Entry) removeOnSwipe;

  const ExpensesList({required this.removeOnSwipe, required this.toDisplayList, super.key});

  @override
  Widget build(BuildContext context) {
    print(toDisplayList);
    return ListView.builder(
      itemCount: toDisplayList.length,
      itemBuilder: (context, index){
        return Dismissible(
          key: ValueKey(toDisplayList[index]), 
          child: ExpenseItem(thisExpense: toDisplayList[index]),
          onDismissed: (direction){
            removeOnSwipe(toDisplayList[index]);
          },  
        );
      },);
  }
}

class ExpenseItem extends StatelessWidget {
  final Entry thisExpense;
  
  ExpenseItem({required this.thisExpense, super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(thisExpense.title),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('₹ ${thisExpense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    catIcons[thisExpense.category]!,
                    Text(thisExpense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}