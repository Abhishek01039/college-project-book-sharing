import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StudentEditModel extends BaseModel {
  Api api = locator<Api>();
  final TextEditingController enrollmentNo = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController collegeName = TextEditingController();
  // final TextEditingController collegeYear = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController address = TextEditingController();
  // final TextEditingController phoneNumber = new TextEditingController();
  String number;
  final formKey = GlobalKey<FormState>();

  String base64Image;

  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;
  String collegeYear = "1";
  String fileName;
  setPhoneNumber(String value) {
    number = value;
    notifyListeners();
  }

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
    print(fileName);
    notifyListeners();
  }

  chooseCollegeYear(String val) {
    collegeYear = val;
    notifyListeners();
  }

  Future<void> updateStudentPhoto(BuildContext context) async {
    await chooseImage();
    await startUpload();
    String studentPhoto = jsonEncode({
      "enrollmentNo": SPHelper.getString("enrollmentNo"),
      "photo": base64Image
    });
    bool isUpdated =
        await api.updateStudentPhoto(SPHelper.getInt("ID"), studentPhoto);
    if (isUpdated) {
      SPHelper.setString("studentPhoto", '/media/Student' + fileName);

      Navigator.pushNamedAndRemoveUntil(
        context,
        'home',
        (Route<dynamic> route) => false,
      );
      showFlutterToast("Profile Image updated successfully");
    } else {
      showFlutterToast("Something went wrong");
    }
  }

  updateStudent() async {
    // api.updateUser(id)
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
      "contactNo": number,
    });
    bool isUpdated =
        await api.updateStudent(SPHelper.getInt("ID"), studentInfo);
    return isUpdated;
  }
}
