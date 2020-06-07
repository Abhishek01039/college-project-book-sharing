import 'dart:convert';

import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
// import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StudentRegModel extends BaseModel with Api {
  // Api = locator<Api>();
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
  String collegeYear = "1";
  String number;
  String photo;
  String isRegistered;
  bool autoValidate = false;
  bool changePasswordAutoValidate = false;
  bool feedbackAutoValidate = false;

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
  List<String> extn;
  String countryCode = "+91";

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);
    // file.then((value) {
    //   isImageSelected = "Image is Selected";
    // });
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
      // print("htllo");
      return;
    }

    String fileName = tmpFile.path.split('/').last;
    // print(fileName);
    extn = fileName.split(".");
    notifyChange();
  }

  chooseCollegeYear(String val) {
    collegeYear = val;
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

          await startUpload();
          isRegistered = await registerStudent(
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
            base64Image,
            extn[1],
          );
          closeProgress(scaffoldKey);
          if (isRegistered == "Success") {
            enrollmentNo.clear();
            firstName.clear();
            lastName.clear();
            email.clear();
            age.clear();
            collegeName.clear();
            course.clear();
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

          showFlutterToast("Password Changed Successfully");
          // changePassformKey.currentState.reset();
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
