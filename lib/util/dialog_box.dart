import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.amountController,
    required this.titleController,
    required this.dateController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        widget.dateController.text = _picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Title
            TextField(
              controller: widget.titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                prefixIcon: Icon(Icons.title),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),

            //Amount
            TextField(
              controller: widget.amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
              ),
            ),

            //Date Selection
            TextField(
              controller: widget.dateController,
              decoration: InputDecoration(
                hintText: 'Select Date',
                prefixIcon: Icon(Icons.calendar_today_rounded),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    String input1 = widget.titleController.text;
                    String input2 = widget.amountController.text;
                    String input3 = widget.dateController.text;
                    double? isNumber = double.tryParse(input2);
                    if (input1.isEmpty || input2.isEmpty || input3.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please enter all fields"),
                          );
                        },
                      );
                    } else if (input1.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please enter a title"),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved Successfully')),
                      );
                      print('$input1, $input2, $input3');
                      widget.onSave();
                      widget.amountController.clear();
                      widget.titleController.clear();
                      widget.dateController.clear();
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
