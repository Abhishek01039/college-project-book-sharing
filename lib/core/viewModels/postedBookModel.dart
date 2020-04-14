import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  List<File> bookImages = new List();
  FileType fileType = FileType.image;
  List<String> base64Image = List();
  List<File> tmpFile = List();
  String isImageSelected = "";
  List<String> fileName = List();
  String errMessage = 'Error Uploading Image';
  // File file;
  String status = '';
  Api api = locator<Api>();
  Book book = locator<Book>();
  bool isPosted;
  bool isEdited;
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
    // bookImages bookImage=BookImage(
    //   image:
    // );
    //     Book book = Book(
    //   bookName: bookName.text,
    //   isbnNo: isbnNo.text,
    //   pubName: pubName.text,
    //   orginialPrice: int.parse(mrpPrice.text),
    //   price: int.parse(price.text),
    //   bookCatgName: bookCatgName.text,
    //   bookImage:
    // );
    // var b = book.toJson();
    // print(b);
    notifyListeners();
  }

  registeredBook(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("msgPleaseCheckConn");
      }

      showProgress(scaffoldKey);
    }
    await startUpload();
    String body = json.encode({
      "bookName": bookName.text,
      "isbnNo": isbnNo.text,
      "authorName": authorName.text,
      "pubName": pubName.text,
      "price": int.tryParse(price.text),
      "bookCatgName": bookCatgName.text,
      "originalPrice": int.tryParse(mrpPrice.text),
      "Book_Image": base64Image,
      "postedBy": SPHelper.getInt("ID")
    });

    isPosted = await api.registeredBook(body);
    closeProgress(scaffoldKey);
    if (isPosted) {
      Navigator.pop(context);
      showFlutterToast("Book Posted Successfully");
    } else {
      showFlutterToast("Somthing went wrong Please try again");
    }
  }

  setPhoneNumber(String value) {
    number = value;
    notifyListeners();
  }

  editBook(int bookid, GlobalKey<ScaffoldState> scaffoldKey) async {
    String editBookData = jsonEncode({
      "bookName": bookName.text,
      "isbnNo": isbnNo.text,
      "authorName": authorName.text,
      "pubName": pubName.text,
      "price": int.tryParse(price.text),
      "bookCatgName": bookCatgName.text,
      "originalPrice": int.tryParse(mrpPrice.text),
      "postedBy": SPHelper.getInt("ID")
    });
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("msgPleaseCheckConn");
      }

      showProgress(scaffoldKey);
    }
    isEdited = await api.editBook(bookid, editBookData);
    closeProgress(scaffoldKey);
  }

  deleteBook(BuildContext context, int bookId) async {
    bool isDeleted = await api.deleteBook(bookId);
    if (isDeleted) {
      Navigator.pop(context);
      showFlutterToast("Book Deleted Successfully");
    } else {
      showFlutterToast("Something went wrong");
    }
  }

  deleteBookByTransaction(BuildContext context, int bookId,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    // await api.
    String body = jsonEncode(
      {"bookId": bookId, "contactNo": number},
    );
    studentName.clear();
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("msgPleaseCheckConn");
      }

      showProgress(scaffoldKey);
    }
    String response = await api.deleteBookAndPost(body);
    closeProgress(scaffoldKey);
    if (response == "Student doesn't exist with this contact Number") {
      showFlutterToast("Student doesn't exist with this contact Number");
    } else if (response == "Success") {
      Navigator.pop(context);
      showFlutterToast("delete Book Successfully");
    } else {
      showFlutterToast("Something went wrong");
    }
  }
}
