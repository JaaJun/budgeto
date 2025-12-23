import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    String input = controller.text;
                    double? isNumber = double.tryParse(input);
                    if (input.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please enter an amount"),
                          );
                        },
                      );
                    } else if (isNumber == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please enter a number"),
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).pop();
                      controller.clear();
                    }
                  }, //add to stats list
                  icon: Icon(Icons.check),
                  label: Text("OK"),
                ),
                ElevatedButton.icon(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.close),
                  label: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
