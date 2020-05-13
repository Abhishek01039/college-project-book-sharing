import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/API/allAPIs.dart';

import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PostedBookModel extends BaseModel {
  TextEditingController bookName = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController pubName = TextEditingController();
  TextEditingController mrpPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bookCatgName = TextEditingController();
  TextEditingController studentName = TextEditingController();
  // TextEditingController bookCatgName = TextEditingController();
  // TextEditingController bookCatgName = TextEditingController();
  String number;
  List<File> bookImages = [];
  FileType fileType = FileType.image;
  List<String> base64Image = [];
  List<File> tmpFile = [];
  String isImageSelected = "";
  List<String> fileName = [];
  String errMessage = 'Error Uploading Image';
  // File file;
  String status = '';
  Api _api = locator<Api>();
  bool isPosted;

  List<String> extn = [];
  chooseBookImage() async {
    bookImages.clear();
    await FilePicker.getMultiFile(type: fileType).then((value) {
      for (var i in value) {
        bookImages.add(i);
      }
    });
    print(bookImages);

    notifyListeners();
  }

  setStatus(String message) {
    status = message;
    notifyListeners();
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
        // print("htllo");
        return;
      }

      fileName.add(tmpFile[i].path.split('/').last);
      // print(fileName);

      // print(base64Image);
    }
    for (var i in fileName) {
      extn.add(i.split(".")[1]);
    }
    print(extn);
    // bookImages bookImage=BookImage(
    //   image:
    // );
    //     Book _book = Book(
    //   bookName: bookName.text,
    //   isbnNo: isbnNo.text,
    //   pubName: pubName.text,
    //   orginialPrice: int.parse(mrpPrice.text),
    //   price: int.parse(price.text),
    //   bookCatgName: bookCatgName.text,
    //   bookImage:
    // );
    // var b = _book.toJson();
    // print(b);
    notifyListeners();
  }

  // post a _book
  registeredBook(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
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
          "bookCatgName": bookCatgName.text,
          "originalPrice": int.tryParse(mrpPrice.text),
          "Book_Image": base64Image,
          "extn": extn,
          "postedBy": box.get("ID")
        });

        isPosted = await _api.registeredBook(body);
        closeProgress(scaffoldKey);
        if (isPosted) {
          Navigator.pop(context);
          showFlutterToast("Book Posted Successfully");
        } else {
          showFlutterToast("Somthing went wrong Please try again");
        }
      }
    }
  }

  setPhoneNumber(String value) {
    number = value;
    notifyListeners();
  }

  // edit the _book

  // delete the _book
  deleteBook(BuildContext context, int bookId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
      } else {
        showProgress(scaffoldKey);
        bool isDeleted = await _api.deleteBook(bookId);
        closeProgress(scaffoldKey);
        if (isDeleted) {
          // Navigator.popUntil(
          //   context,
          //   ModalRoute.withName('myPostedBook'),
          // );
          Navigator.pushNamedAndRemoveUntil(
            context,
            'home',
            (Route<dynamic> route) => false,
          );

          showFlutterToast("Book Deleted Successfully");
        } else {
          closeProgress(scaffoldKey);
          showFlutterToast("Something went wrong");
        }
      }
    }
  }

  // ensure that you have sold your _book to other student
  deleteBookByTransaction(BuildContext context, int bookId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    // await _api.
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
        String response = await _api.deleteBookAndPost(body);
        closeProgress(scaffoldKey);
        if (response == "Student doesn't exist with this contact Number") {
          showFlutterToast("Student doesn't exist with this contact Number");
        } else if (response == "Success") {
          // Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            'home',
            (Route<dynamic> route) => false,
          );
          showFlutterToast("delete Book Successfully");
        } else {
          showFlutterToast("Something went wrong");
        }
        closeProgress(scaffoldKey);
      }
    }
  }
}
