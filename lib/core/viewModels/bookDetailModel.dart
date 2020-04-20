// import 'dart:convert';
// import 'dart:io';

// import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

class BookDetailModel extends BaseModel {
  Student student = locator<Student>();
  Api api = locator<Api>();
  String postedBy;

  getStudentDetail(int id) async {
    student = await api.getStudentById(id);
    return student;
  }

  floatingActionButtonEnable() {
    postedBy = "You";
    // print("You");
    notifyListeners();
  }
}
