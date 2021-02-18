import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PostedBookModel extends BaseModel with Api {
  final TextEditingController bookName = TextEditingController();
  final TextEditingController isbnNo = TextEditingController();
  final TextEditingController authorName = TextEditingController();
  final TextEditingController pubName = TextEditingController();
  final TextEditingController mrpPrice = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController edition = TextEditingController();
  final TextEditingController bookCatgName = TextEditingController();
  final TextEditingController studentName = TextEditingController();
  String number;
  List<File> bookImages = <File>[];
  FileType fileType = FileType.image;
  List<String> base64Image = <String>[];
  List<File> tmpFile = <File>[];
  String isImageSelected = "";
  List<String> fileName = <String>[];
  String errMessage = 'Error Uploading Image';
  String status = '';
  bool isPosted;
  bool autoValidate = false;
  final formKey = GlobalKey<FormState>();

  List<String> extn = <String>[];
  chooseBookImage() async {
    bookImages.clear();
    await FilePicker.getMultiFile(type: fileType).then((value) {
      for (var i in value) {
        bookImages.add(i);
      }
    });
    print(bookImages);

    notifyChange();
  }

  setStatus(String message) {
    status = message;
    notifyChange();
  }

  startUpload() async {
    print("presseed");
    setStatus('Uploading Image...');
    tmpFile.clear();
    base64Image.clear();
    for (int i = 0; i < bookImages.length; i++) {
      tmpFile.add(bookImages[i]);
      base64Image.add(base64Encode(tmpFile[i].readAsBytesSync()));
      if (null == tmpFile) {
        setStatus(errMessage);

        return;
      }

      fileName.add(tmpFile[i].path.split('/').last);
    }
    for (var i in fileName) {
      extn.add(i.split(".")[1]);
    }
    print(extn);

    notifyChange();
  }

  Future<bool> registeredBookProvider(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (formKey.currentState.validate()) {
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");
        } else {
          showProgress(scaffoldKey);

          await startUpload();
          final box = Hive.box("Student");
          String body = json.encode({
            "bookName": bookName.text,
            "isbnNo": isbnNo.text,
            "authorName": authorName.text,
            "pubName": pubName.text,
            "price": int.tryParse(price.text),
            "edition": edition.text ?? "",
            "bookCatgName": bookCatgName.text,
            "originalPrice": int.tryParse(mrpPrice.text),
            "Book_Image": base64Image,
            "extn": extn,
            "postedBy": box.get("ID")
          });

          isPosted = await registeredBook(body);
          closeProgress(scaffoldKey);
          if (isPosted) {
            Navigator.pop(context);
            showFlutterToast("Book Posted Successfully");
            formKey.currentState.reset();
            return true;
          } else {
            showFlutterToast("Somthing went wrong Please try again");
            return false;
          }
        }
      }
    } else {
      changeAutoValidate();
      return true;
    }
    return false;
  }

  setPhoneNumber(String value) {
    number = value;
    notifyChange();
  }

  Future<bool> deleteBookProvider(BuildContext context, int bookId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
      } else {
        showProgress(scaffoldKey);
        bool isDeleted = await deleteBook(bookId);
        closeProgress(scaffoldKey);
        if (isDeleted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            'home',
            (Route<dynamic> route) => false,
          );

          showFlutterToast("Book Deleted Successfully");
          return true;
        } else {
          closeProgress(scaffoldKey);
          showFlutterToast("Something went wrong");
          return false;
        }
      }
    }
    return false;
  }

  Future<bool> deleteBookByTransaction(BuildContext context, int bookId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    String body = jsonEncode(
      {"bookId": bookId, "contactNo": number},
    );
    studentName.clear();
    showProgress(scaffoldKey);
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
        closeProgress(scaffoldKey);
      } else {
        String response = await deleteBookAndPost(body);
        closeProgress(scaffoldKey);
        if (response == "Student doesn't exist with this contact Number") {
          showFlutterToast("Student doesn't exist with this contact Number");
        } else if (response == "Success") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            'home',
            (Route<dynamic> route) => false,
          );
          showFlutterToast("delete Book Successfully");
          return true;
        } else {
          showFlutterToast("Something went wrong");
          return false;
        }
        closeProgress(scaffoldKey);
        return false;
      }
    }
    return false;
  }

  changeAutoValidate() {
    autoValidate = true;
    notifyChange();
  }
}
