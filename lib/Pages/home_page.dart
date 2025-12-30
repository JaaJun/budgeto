import 'package:budgeto/util/dialog_box.dart';
import 'package:budgeto/util/logout_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/expense_tile.dart';
// import 'stats_page.dart';

/// This Dart class named HomePage extends StatelessWidget.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();

  List expenseList = [];

  void createNewEntry() {
    // Logic to create a new entry goes here
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: titleController,
          dateController: dateController,
          amountController: amountController,
          onSave: () {
            if (!mounted) return;
            setState(() {
              expenseList.add([
                titleController.text,
                dateController.text,
                amountController.text,
              ]);
            });
            titleController.clear();
            dateController.clear();
            amountController.clear();
          },
          onCancel: () {
            // Cancel action logic
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void saveNewRecord() {
    // Logic to save a new record goes here
    if (!mounted) return;
    setState(() {
      // Update state with new record
      expenseList.add([
        titleController.text,
        dateController.text,
        amountController.text,
      ]);
    });
    titleController.clear();
    dateController.clear();
    amountController.clear();
  }

  double get totalSpent {
    double total = 0.0;
    for (var expense in expenseList) {
      // .trim() removes accidental spaces
      // .replaceAll removes '£' if the user accidentally typed it in the box
      String cleanAmount = expense[2].toString().replaceAll('£', '').trim();
      total += double.tryParse(cleanAmount) ?? 0.0;
    }
    return total;
  }

  double get remainingTotal {
    double totalRemaining = 300.0;
    for (var expense in expenseList) {
      // .trim() removes accidental spaces
      // .replaceAll removes '£' if the user accidentally typed it in the box
      String cleanRemaining = expense[2].toString().replaceAll('£', '').trim();
      totalRemaining -= double.tryParse(cleanRemaining) ?? 0.0;
    }
    return totalRemaining;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Logged in as: ' + (user?.email ?? ''),
              ), // Show nothing if no user
              SizedBox(width: 10),
              LogoutButton(
                onLogout: () {
                  if (!mounted) return;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.green[100]!, width: 3),
                ),
                padding: EdgeInsets.all(20),
                // margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text("Remaining:"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('£'),
                        Text(remainingTotal.toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red[100]!, width: 3),
                ),
                padding: EdgeInsets.all(20),
                // margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text("Spent:"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('£'),
                        Text(totalSpent.toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Recent Records',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView.builder(
                      itemCount: expenseList.length,
                      itemBuilder: ((context, index) {
                        return ExpenseTile(
                          title: expenseList[index][0],
                          date: expenseList[index][1],
                          amount: expenseList[index][2],
                          images: null,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                titleController: titleController,
                dateController: dateController,
                amountController: amountController,
                onSave: saveNewRecord,
                onCancel: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
