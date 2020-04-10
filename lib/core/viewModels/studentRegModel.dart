import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StudentRegModel extends BaseModel {
  Api api = locator<Api>();
  final TextEditingController enrollmentNo = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController collegeName = TextEditingController();
  // final TextEditingController collegeYear = TextEditingController();
  final TextEditingController course = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController changePassword = TextEditingController();
  final TextEditingController changeNewPassword = TextEditingController();
  final TextEditingController changeNewConfirmPassword =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final changePassformKey = GlobalKey<FormState>();
  String collegeYear = "1";
  String number;
  String photo;
  bool isRegistered;

  // studentRegistration() async {
  //   if (formKey.currentState.validate()) {
  //     log(enrollmentNo.text.toString());
  //     log(firstName.text.toString());
  //     log(lastName.text.toString());
  //     log(email.text.toString());
  //     log(age.text.toString());
  //     log(password.text.toString());
  //     log(collegeYear.toString());
  //     // log(number);
  //     print("number is" + number);
  //   }
  // }

  String base64Image;
  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);
    // file.then((value) {
    //   isImageSelected = "Image is Selected";
    // });
    setStatus('');

    notifyListeners();
  }

  setStatus(String message) {
    status = message;
    notifyListeners();
  }

  startUpload() async {
    print("presseed");
    setStatus('Uploading Image...');
    tmpFile = file;
    base64Image = base64Encode(tmpFile.readAsBytesSync());
    if (null == tmpFile) {
      setStatus(errMessage);
      // print("htllo");
      return;
    }

    // String fileName = tmpFile.path.split('/').last;
    // print(fileName);
    notifyListeners();
  }

  chooseCollegeYear(String val) {
    collegeYear = val;
    notifyListeners();
  }

  Future<bool> registerStudent() async {
    if (formKey.currentState.validate()) {
      await startUpload();
      var body = {
        "enrollmentNo": enrollmentNo.text,
        "firstName": firstName.text,
        "lastName": lastName.text,
        "email": email.text,
        "age": int.tryParse(age.text),
        "password": password.text,
        "collegeName": collegeName.text,
        "collegeYear": collegeYear,
        "course": course.text ?? "",
        "address": address.text,
        "contactNo": number,
        "photo": base64Image ?? "",
      };
      print(body);

      isRegistered = await api.registerStudent(
          enrollmentNo.text,
          firstName.text,
          lastName.text,
          email.text,
          age.text,
          password.text,
          collegeName.text,
          collegeYear,
          course.text,
          address.text,
          number,
          base64Image);
      return isRegistered;
    }
    return false;
  }

  setPhoneNumber(String value) {
    number = value;
    notifyListeners();
  }

  changePasswordModel(BuildContext context, int studId) async {
    if (!changePassformKey.currentState.validate()) {
      return;
    }
    String value = await api.changePassword(
        studId, changePassword.text, changeNewPassword.text);

    if (value == "Success") {
      changePassword.clear();
      changeNewPassword.clear();
      changeNewConfirmPassword.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, 'home', (Route<dynamic> route) => false);

      showFlutterToast("Password Changed Successfully");
    } else if (value == "Enter Right Old Password") {
      showFlutterToast("Old Password does't match");
    } else {
      showFlutterToast("Something went wrong");
    }
  }
}
