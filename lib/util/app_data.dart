import 'dart:io';

class appData {
  final String title;
  final String date;
  final double amount;
  final File? images;

  appData({
    required this.title,
    required this.date,
    required this.amount,
    this.images,
  });
}
