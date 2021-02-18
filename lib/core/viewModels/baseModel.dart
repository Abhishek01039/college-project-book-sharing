import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BaseModel extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  changeTheme(bool value) {
    final darkTheme = Hive.box("DarkTheme");
    _isDarkTheme = value;
    darkTheme.put("darkTheme", value);
    notifyListeners();
  }

  void notifyChange() {
    notifyListeners();
  }
}
