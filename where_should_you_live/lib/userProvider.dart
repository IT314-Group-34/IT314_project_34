import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}
