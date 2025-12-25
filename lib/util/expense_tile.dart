import 'package:flutter/material.dart';
import 'dart:io';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final File? images;
  const ExpenseTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.images, //not required since may not have image
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //Expense Icon
            Padding(padding: EdgeInsets.all(3.0)),
            images != null
                ? Image.file(images!)
                : const Icon(Icons.money_rounded, size: 30),
            //Expense Title and Date Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Expense Title
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

                    //Expense Date Description
                    Text(date, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            //Expense Amount
            Text('£$amount'),
          ],
        ),
      ),
    );
  }
}
