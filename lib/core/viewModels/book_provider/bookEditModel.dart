import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
// import 'core/API/allAPIs.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PostedBookEditModel extends BaseModel {
  TextEditingController bookName = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController pubName = TextEditingController();
  TextEditingController mrpPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bookCatgName = TextEditingController();
  TextEditingController studentName = TextEditingController();

  Student _student = locator<Student>();
  Api _api = locator<Api>();
  bool isEdited;

  String base64Image;
  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;
  List<String> extn = [];
  String countryCode = "+91";

  List<File> bookImages = [];

  List<String> base64ImageList = [];
  List<File> tmpFileList = [];
  // String isImageSelected = "";
  List<String> fileName = [];
  bool autoValidate = false;
  final formKey = GlobalKey<FormState>();

  editBook(int bookid, GlobalKey<ScaffoldState> scaffoldKey) async {
    if (formKey.currentState.validate()) {
      final box = Hive.box("Student");
      String editBookData = jsonEncode({
        "bookName": bookName.text,
        "isbnNo": isbnNo.text,
        "authorName": authorName.text,
        "pubName": pubName.text,
        "price": int.tryParse(price.text),
        "bookCatgName": bookCatgName.text,
        "originalPrice": int.tryParse(mrpPrice.text),
        "postedBy": box.get("ID")
      });
      if (scaffoldKey != null) {
        if (await checkConnection() == false) {
          showFlutterToast("Please check internet connection");
          return null;
        }

        showProgress(scaffoldKey);
      }
      isEdited = await _api.editBook(bookid, editBookData);
      closeProgress(scaffoldKey);
    } else {
      changeAutoValidate();
    }
  }

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);
    // file.then((value) {
    //   isImageSelected = "Image is Selected";
    // });

    notifyListeners();
    setStatus('');
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

    String fileName = tmpFile.path.split('/').last;
    // print(fileName);
    extn = fileName.split(".");
    notifyListeners();
  }

  // give book whole detail according to ID and show it into book detail page
  getStudentDetail(int id) async {
    _student = await _api.getStudentById(id);
    return _student;
  }

  updateImage(BuildContext context, String bookName, int imageId, int count,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    // showProgress(scaffoldKey);
    if (file != null) {
      await startUpload();
      String imageUpdateById = jsonEncode({
        "count": count,
        "bookId": imageId,
        "bookName": bookName,
        "image": base64Image,
        "extansion": extn[1],
      });

      var parsed = await _api.updateImagePhoto(imageUpdateById);
      // closeProgress(scaffoldKey);
      if (parsed == "Success") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (Route<dynamic> route) => false,
        );
        showFlutterToast("Book Image updated successfully");
      } else {
        showFlutterToast("Something went wrong");
      }
    }
  }

  chooseBookImageList() async {
    bookImages.clear();
    bool isSelected =
        await FilePicker.getMultiFile(type: fileType).then((value) {
      if (value == null) {
        return false;
      }
      for (var i in value) {
        bookImages.add(i);
      }
      return true;
    });
    notifyListeners();
    if (isSelected) {
      return true;
    } else {
      return false;
    }
  }

  setStatusList(String message) {
    status = message;
    notifyListeners();
  }

  startUploadList() async {
    setStatus('Uploading Image...');
    extn.clear();
    tmpFileList.clear();
    fileName.clear();
    base64ImageList.clear();
    for (int i = 0; i < bookImages.length; i++) {
      tmpFileList.add(bookImages[i]);
      base64ImageList.add(base64Encode(tmpFileList[i].readAsBytesSync()));
      if (null == tmpFileList) {
        setStatus(errMessage);
        // print("htllo");
        return;
      }

      fileName.add(tmpFileList[i].path.split('/').last);
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

  updateBookImageList(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey, int bookId, String bookName) async {
    // showProgress(scaffoldKey);
    if (scaffoldKey != null) {
      if (await checkConnection() == false) {
        showFlutterToast("Please check internet connection");
        closeProgress(scaffoldKey);
      } else {
        chooseBookImageList().then((value) async {
          if (value) {
            await startUploadList();
            String body = json.encode({
              "bookId": bookId,
              "bookName": bookName,
              "Book_Image": base64ImageList,
              "extn": extn,
            });

            String isPosted = await _api.addImageList(body);
            // closeProgress(scaffoldKey);
            if (isPosted == "Success") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'home',
                (Route<dynamic> route) => false,
              );
              showFlutterToast("Book Posted Successfully");
            } else {
              showFlutterToast("Somthing went wrong Please try again");
            }
          } else {
            log("message");
          }
        });
      }

      // showProgress(scaffoldKey);
    }
  }

  changeAutoValidate() {
    autoValidate = true;
    notifyListeners();
  }
}
