import 'package:expensetrackerflutterapp/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expensetrackerflutterapp/models/expense.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _reqgisteredExpenses = [
    Expense(
        title: "Eating outside",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Going to beach",
        amount: 100,
        date: DateTime.now(),
        category: Category.travel)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(expenses: _reqgisteredExpenses))
        ],
      ),
    );
  }
}
