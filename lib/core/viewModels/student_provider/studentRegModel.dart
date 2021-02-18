import 'dart:convert';

import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentRegModel extends BaseModel with Api {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController changePasswordTextController =
      TextEditingController();
  final TextEditingController changeNewPassword = TextEditingController();
  final TextEditingController feedBackMessage = TextEditingController();
  final TextEditingController feedBackEmail = TextEditingController();
  final TextEditingController changeNewConfirmPassword =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final feedbackFormKey = GlobalKey<FormState>();
  final changePassformKey = GlobalKey<FormState>();
  String number;
  String photo;
  String isRegistered;
  bool autoValidate = false;
  bool changePasswordAutoValidate = false;
  bool feedbackAutoValidate = false;
  final box = Hive.box("Student");
  String base64Image;
  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;
  List<String> extn;
  String countryCode = "+91";

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);

    setStatus('');

    notifyChange();
  }

  setStatus(String message) {
    status = message;
    notifyChange();
  }

  startUpload() async {
    print("presseed");
    setStatus('Uploading Image...');
    tmpFile = file;
    base64Image = base64Encode(tmpFile.readAsBytesSync());
    if (null == tmpFile) {
      setStatus(errMessage);

      return;
    }

    String fileName = tmpFile.path.split('/').last;

    extn = fileName.split(".");
    notifyChange();
  }

  registerStudentProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (formKey.currentState.validate()) {
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");
        } else {
          showProgress(scaffoldKey);
          if (file != null) {
            await startUpload();
          }
          isRegistered = await registerStudent(
            firstName.text,
            lastName.text,
            email.text,
            age.text,
            password.text,
            address.text,
            number,
            base64Image ?? "",
            extn == null ? "" : extn[1] ?? "",
          );
          closeProgress(scaffoldKey);
          if (isRegistered == "Success") {
            firstName.clear();
            lastName.clear();
            email.clear();
            age.clear();

            password.clear();
            confirmPass.clear();
            phoneNumber.clear();
            address.clear();
            number = "";

            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (Route<dynamic> route) => false);
            showFlutterToast("Registration Successfully");
            formKey.currentState.reset();
          } else if (isRegistered == "Student already Exist") {
            showFlutterToast("Student already exist");
          } else if (isRegistered == "Mobile Number is already exist") {
            showFlutterToast("Mobile Number is already exist");
          } else if (isRegistered ==
              "Student with this email is already exist") {
            showFlutterToast("Student with this email is already exist");
          } else {
            showFlutterToast("Somthing went wrong Please try again");
          }
        }
      }
    } else {
      changeAutoValidate();
    }
  }

  setPhoneNumber(String value) {
    number = value;
    notifyChange();
  }

  changeCountryCode(String value) {
    countryCode = "+" + value;
    setPhoneNumber("+" + value + number);
    notifyChange();
  }

  changePasswordModel(BuildContext context, int studId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    if (!changePassformKey.currentState.validate()) {
      changeChangePasswordAutoValidate();
      return;
    }
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
      } else {
        showProgress(scaffoldKey);

        String value = await changePassword(
            studId, changePasswordTextController.text, changeNewPassword.text);
        closeProgress(scaffoldKey);
        if (value == "Success") {
          changePasswordTextController.clear();
          changeNewPassword.clear();
          changeNewConfirmPassword.clear();
          Navigator.pushNamedAndRemoveUntil(
              context, 'home', (Route<dynamic> route) => false);
          changePassformKey.currentState.reset();
          showFlutterToast("Password Changed Successfully");
        } else if (value == "Enter Right Old Password") {
          showFlutterToast("Old Password does't match");
        } else {
          showFlutterToast("Something went wrong");
        }
      }
    }
  }

  feedBackProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (feedbackFormKey.currentState.validate()) {
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");
        } else {
          showProgress(scaffoldKey);

          feedBack(feedBackEmail.text, feedBackMessage.text).then((value) {
            closeProgress(scaffoldKey);
            if (value == "Success") {
              Navigator.pop(context);
              showFlutterToast("Feed Back has been successfully submitted");
              feedbackFormKey.currentState.reset();
            } else {
              showFlutterToast("Something went wrong");
            }
          });
        }
      }
    } else {
      changeFeedBackAutoValidate();
    }
  }

  changeAutoValidate() {
    autoValidate = true;
    notifyChange();
  }

  changeChangePasswordAutoValidate() {
    changePasswordAutoValidate = true;
    notifyChange();
  }

  changeFeedBackAutoValidate() {
    feedbackAutoValidate = true;
    notifyChange();
  }
}
