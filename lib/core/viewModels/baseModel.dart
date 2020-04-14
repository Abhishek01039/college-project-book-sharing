import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  // SPHelper.setInt("DarkTheme", 1);
  @override
  void dispose() {
    super.dispose();
  }

  changeTheme(bool value) {
    // if (_isDarkTheme) {
    //   _isDarkTheme = false;
    //   SPHelper.setInt("DarkTheme", 1);
    // } else {
    _isDarkTheme = value;
    SPHelper.setBool("DarkTheme", value);
    // }
    notifyListeners();
  }

  void notifyChange() {
    notifyListeners();
  }
}
