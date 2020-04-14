import 'package:booksharing/UI/shared/commonUtility.dart';
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

  Future<bool> logIn(GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("msgPleaseCheckConn");
      }

      showProgress(scaffoldKey);
    }
    bool value = await _api.logIn(username.text, pass.text).then((value) {
      closeProgress(scaffoldKey);
      if (value != null) {
        return true;
      }
      return false;
    });
    return value;
    // print(student);
  }
}
