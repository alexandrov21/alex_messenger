import 'package:alex_messenger/models/all_dialogs_model.dart';
import 'package:flutter/material.dart';

abstract class AllDialogsMock {
  static final List<AllDialogsModel> allDialogs = [
    AllDialogsModel(
      'AA',
      'Alex Alexandrov',
      'Last saved message',
      Colors.deepOrange,
    ),
    AllDialogsModel('OK', 'Olena Kozhukhar', 'hi, how are you?', Colors.green),
    AllDialogsModel('JY', 'John Yers', 'what\'s your name?', Colors.pinkAccent),
    AllDialogsModel(
      'MS',
      'Maria Shevchenko',
      'Voice message',
      Colors.yellowAccent,
    ),
  ];
}
