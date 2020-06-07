import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
// import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentEditModel extends BaseModel with Api {
  // Api = locator<Api>();
  final TextEditingController enrollmentNo = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController collegeName = TextEditingController();
  // final TextEditingController collegeYear = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController emailOTP = TextEditingController();
  final TextEditingController oTP = TextEditingController();
  final TextEditingController passwordAfterOTP = TextEditingController();
  final TextEditingController confirmPasswordAfterOTP = TextEditingController();
  int verifyOTP;
  // final TextEditingController phoneNumber = new TextEditingController();
  String number;
  final formKey = GlobalKey<FormState>();
  final sendOTPFrom = GlobalKey<FormState>();
  final verifyOTPFrom = GlobalKey<FormState>();
  // final corfirmFrom = GlobalKey<FormState>();
  final changePassowdForm = GlobalKey<FormState>();
  String base64Image;

  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;
  String collegeYear = "1";
  String fileName;
  List<String> extn;
  String editNumber;
  String countryCode = "+91";
  int otp;
  bool autoValidate = false;
  bool changePasswordAutoValidate = false;

  setPhoneNumber(String value) {
    number = value;
    notifyChange();
  }

  changeCountryCode(String value) {
    countryCode = value;
    // if (editNumber == null) {
    //   updatePhoneNumber("+" + value + number.substring(3));
    // } else {
    //   updatePhoneNumber("+" + value + editNumber);
    // }

    // notifyChange();
  }

  updatePhoneNumber(String value) {
    editNumber = "+" + countryCode + value;
    // notifyChange();
  }
  // changeTheme(){
  //   if (super.isDarkTheme){
  //     super.isDarkTheme=false;
  //   }else{
  //     super.isDarkTheme=true;
  //   }
  //   notifyChange();
  // }

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);
    // file.then((value) {
    //   isImageSelected = "Image is Selected";
    // });
    setStatus('');
    if (file == null) {
      // showFlutterToast("Please select Image");
      return false;
    }

    notifyChange();
    return true;
  }

  setStatus(String message) {
    status = message;
    notifyChange();
  }

  startUpload() async {
    // print("presseed");
    setStatus('Uploading Image...');
    tmpFile = file;
    base64Image = base64Encode(tmpFile.readAsBytesSync());
    if (null == tmpFile) {
      setStatus(errMessage);
      // print("htllo");
      return;
    }

    fileName = tmpFile.path.split('/').last;
    // print(fileName);
    extn = fileName.split(".");

    notifyChange();
  }

  chooseCollegeYear(String val) {
    collegeYear = val;
    notifyChange();
  }

  // update student photo
  Future<void> updateStudentPhotoProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    chooseImage().then((value) async {
      final box = Hive.box("Student");
      if (value) {
        showProgress(scaffoldKey);
        await startUpload();
        String studentPhoto = jsonEncode({
          "enrollmentNo": box.get("enrollmentNo"),
          "photo": base64Image,
          "extansion": extn[1],
        });
        bool isUpdated = await updateStudentPhoto(box.get("ID"), studentPhoto);
        if (isUpdated) {
          box.put("studentPhoto",
              '/media/Student/' + box.get("enrollmentNo") + '.' + extn[1]);

          Navigator.pushNamedAndRemoveUntil(
            context,
            'home',
            (Route<dynamic> route) => false,
          );
          showFlutterToast("Profile Image updated successfully");
        } else if (!isUpdated) {
          showFlutterToast("Profile Image not updated");
        } else {
          showFlutterToast("Something went wrong");
        }
      }
    });
    closeProgress(scaffoldKey);
  }

  // update student details
  updateStudentProvider(GlobalKey<ScaffoldState> scaffoldKey) async {
    if (formKey.currentState.validate()) {
      // updateUser(id)
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");

          return "";
        } else {
          showProgress(scaffoldKey);

          final box = Hive.box("Student");
          String studentInfo = jsonEncode({
            "enrollmentNo": enrollmentNo.text,
            "firstName": firstName.text,
            "lastName": lastName.text,
            "email": email.text,
            "age": int.tryParse(age.text),
            "collegeName": collegeName.text,
            "collegeYear": int.tryParse(collegeYear),
            "course": course.text,
            "address": address.text,
            "contactNo": editNumber ?? number,
          });
          String isUpdated = await updateStudent(box.get("ID"), studentInfo);
          if (isUpdated == "true") {
            box.put("enrollmentNo", enrollmentNo.text);
            box.put("studentName", firstName.text);
            // box.put("studentPhoto", student.photo);
          }
          closeProgress(scaffoldKey);
          return isUpdated;
        }
      } else {
        showFlutterToast("Something went wrong. Please try again");
      }
      return "";
    } else {
      changeAutoValiate();
      return null;
    }
  }

  // delete the student
  deleteStudentProvider(BuildContext context, int studId) async {
    bool isDeleted = await deleteStudent(studId);
    if (isDeleted) {
      final box = Hive.box("Student");
      showFlutterToast("Account Deleted Successfully");

      box.clear();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
      );
    } else {
      showFlutterToast("Something went wrong");
      Navigator.pop(context);
    }
  }

  sendEmailProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
        return null;
      } else {
        if (sendOTPFrom.currentState.validate()) {
          showProgress(scaffoldKey);
          String value = jsonEncode({"email": emailOTP.text});
          otp = await sendEmail(value);
          closeProgress(scaffoldKey);
          if (otp != null) {
            // varifyEmail(otp, context);
            Navigator.pushNamed(context, 'enterOTP');
          } else {
            showFlutterToast("Something went wrong");
          }
          print(otp);
        }
      }
    }
  }

  varifyEmail(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
        return null;
      } else {
        if (verifyOTPFrom.currentState.validate()) {
          showProgress(scaffoldKey);
          if (otp == int.tryParse(oTP.text)) {
            closeProgress(scaffoldKey);
            oTP.clear();
            Navigator.pushNamed(context, 'changePasswordAfterOTP');
            // showFlutterToast("message")
            verifyOTPFrom.currentState.reset();
          } else {
            closeProgress(scaffoldKey);
            oTP.clear();
            showFlutterToast("Please enter right OTP");
          }
        }
      }
    }
  }

  updatePasswordProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (changePassowdForm.currentState.validate()) {
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");
          return null;
        } else {
          if (changePassowdForm.currentState.validate()) {
            showProgress(scaffoldKey);
            String body = jsonEncode(
                {"email": emailOTP.text, "password": passwordAfterOTP.text});
            String update = await updatePassword(body);

            closeProgress(scaffoldKey);
            if (update == "success") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (Route<dynamic> route) => false,
              );
              emailOTP.clear();
              passwordAfterOTP.clear();
              confirmPasswordAfterOTP.clear();
              showFlutterToast("Password has been updated");
              changePassowdForm.currentState.reset();
            } else {
              showFlutterToast("Something went wrong");
            }
          }
        }
      }
    } else {
      changeChangePasswordAutoValidate();
    }
  }

  changeAutoValiate() {
    autoValidate = true;
    notifyChange();
  }

  changeChangePasswordAutoValidate() {
    changePasswordAutoValidate = true;
    notifyChange();
  }
}
