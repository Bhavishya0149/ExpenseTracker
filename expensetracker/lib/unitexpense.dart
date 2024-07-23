import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuidObj = Uuid();

enum Category { food, travel, work, leisure }
const catIcons = {
  Category.food : Icon(Icons.lunch_dining),
  Category.travel : Icon(Icons.train),
  Category.work : Icon(Icons.work),
  Category.leisure : Icon(Icons.movie)
};

class Entry{
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  final Category category;

  Entry({required this.title, required this.amount, required this.date, required this.category}) : id = uuidObj.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}