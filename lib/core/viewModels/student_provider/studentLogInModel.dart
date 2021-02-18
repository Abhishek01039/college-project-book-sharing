import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';

import 'package:flutter/material.dart';

class StudentModel extends BaseModel with Api {
  final TextEditingController username = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  logInProvider(GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
        return null;
      } else {
        showProgress(scaffoldKey);
        bool value = await logIn(username.text, pass.text).then((value) {
          closeProgress(scaffoldKey);
          if (value != null) {
            return true;
          }
          return false;
        });
        return value;
      }
    } else {
      showFlutterToast("Something went wrong. Please try again");
    }
    return;
  }

  changeAutoValidate() {
    autoValidate = true;
    notifyChange();
  }
}
