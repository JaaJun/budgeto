import 'package:budgeto/util/dialog_box.dart';
import 'package:flutter/material.dart';

/// This Dart class named HomePage extends StatelessWidget.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();

  // void saveNewEntry() {
  //   setState(() {
  //     expenseList.add();
  //   });
  // }

  void createNewEntry() {
    // Logic to create a new entry goes here
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {},
          onCancel: () {
            // Cancel action logic
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green[100]!, width: 3),
            ),
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.only(top: 50, bottom: 50),
            child: Text("Remaining:"),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red[100]!, width: 3),
            ),
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.only(top: 50, bottom: 50),
            child: Text("Spent:"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                controller: _controller,
                onSave: () {},
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
