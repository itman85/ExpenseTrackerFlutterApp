import 'package:expensetrackerflutterapp/widgets/chart/chart.dart';
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
        isScrollControlled: true, // make the bottom sheet fullscreen
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

  void _removeExpense(Expense expense) {
    final expenseIndex = _reqgisteredExpenses.indexOf(expense);
    setState(() {
      _reqgisteredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense removed'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _reqgisteredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expenses found, start adding some!"),
    );
    if (_reqgisteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _reqgisteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

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
          Chart(expenses: _reqgisteredExpenses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
