import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BaseModel extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  // SPHelper.setInt("DarkTheme", 1);
  @override
  void dispose() {
    super.dispose();
  }

  // change theme of App and store it into shared preference
  changeTheme(bool value) {
    final darkTheme = Hive.box("DarkTheme");
    // if (_isDarkTheme) {
    //   _isDarkTheme = false;
    //   SPHelper.setInt("DarkTheme", 1);
    // } else {
    _isDarkTheme = value;

    // }
    darkTheme.put("darkTheme", value);
    notifyListeners();
  }

  void notifyChange() {
    notifyListeners();
  }
}
