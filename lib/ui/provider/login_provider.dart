import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool p) {
    _showPassword = p;
    notifyListeners();
  }
}
