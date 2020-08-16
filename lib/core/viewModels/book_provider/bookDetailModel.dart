// import 'dart:convert';
// import 'dart:io';

// import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';

import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

class BookDetailModel extends BaseModel with Api {
  Student _student = locator<Student>();
  // Api _api = locator<Api>();
  String postedBy;

  Future<Student> getStudentDetail(int id) async {
    _student = await getStudentById(id);
    return _student;
  }

  floatingActionButtonEnable() {
    postedBy = "You";
    // print("You");
    notifyChange();
  }
}
