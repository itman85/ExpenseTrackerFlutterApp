import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expensetrackerflutterapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickerDate = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: firstDate,
            lastDate: now) /*.then((value) {

        })*/
        ;
    setState(() {
      _selectedDate = pickerDate;
    });
  }

  void _submitExpenseData() {
    final enterAmount = double.tryParse(_amountController.text);
    final amountIsInValid = enterAmount == null || enterAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInValid ||
        _selectedDate == null) {
      // show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please make sure input valid data'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('OK'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enterAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context); // close bottom sheet after submit
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$ ', label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date selectd'
                            : fomatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context); // remove the popup from screen
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
