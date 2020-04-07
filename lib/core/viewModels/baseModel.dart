import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  
  @override
  void dispose() {
    super.dispose();
  }

  void notifyChange() {
    notifyListeners();
  }
}
