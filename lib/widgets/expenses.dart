import 'package:expensetrackerflutterapp/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expensetrackerflutterapp/models/expense.dart';
import 'package:flutter/widgets.dart';
import 'package:expensetrackerflutterapp/widgets/new_expense.dart';

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

  void _openAddExpensePopup() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _reqgisteredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpensePopup, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(expenses: _reqgisteredExpenses))
        ],
      ),
    );
  }
}
