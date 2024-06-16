import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(label: Text('Title')),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(prefixText: '\$ ', label: Text('Amount')),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); // remove the popup from screen
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                  },
                  child: Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
