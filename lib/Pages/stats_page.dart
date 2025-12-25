import 'package:budgeto/util/expense_tile.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  final List<dynamic> expenseList;
  const StatsPage({super.key, required this.expenseList});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Records"),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: ListView.builder(
        itemCount: widget.expenseList.length,
        itemBuilder: (context, index) {
          return ExpenseTile(
            title: widget.expenseList[index][0],
            date: widget.expenseList[index][1],
            amount: widget.expenseList[index][2],
            images: null,
          );
        },
      ),
    );
  }
}
