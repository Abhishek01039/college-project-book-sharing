import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:flutter/material.dart';

class StudentModel extends BaseModel {
  Api _api = locator<Api>();
  Student student = locator<Student>();
  final TextEditingController username = TextEditingController();
  final TextEditingController pass = TextEditingController();

  Future<bool> logIn() async {
    student = await _api.logIn(username.text, pass.text);
    // print(student);
    if (student != null) {
      return true;
    }
    return false;
  }
}
