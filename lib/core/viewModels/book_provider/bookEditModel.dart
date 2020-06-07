import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
// import 'core/API/allAPIs.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PostedBookEditModel extends BaseModel with Api {
  TextEditingController bookName = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController pubName = TextEditingController();
  TextEditingController mrpPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bookCatgName = TextEditingController();
  TextEditingController studentName = TextEditingController();
  // BookModel _bookModel = locator<BookModel>();
  Student _student = locator<Student>();
  // Api _api = locator<Api>();
  String isEdited;

  String base64Image;
  File tmpFile;
  String isImageSelected = "";
  String errMessage = 'Error Uploading Image';
  File file;
  String status = '';
  FileType fileType = FileType.image;
  List<String> extn = <String>[];
  String countryCode = "+91";

  List<File> bookImages = <File>[];

  List<String> base64ImageList = <String>[];
  List<File> tmpFileList = <File>[];
  // String isImageSelected = "";
  List<String> fileName = <String>[];
  bool autoValidate = false;
  final formKey = GlobalKey<FormState>();

  Future<bool> editBookProvider(int bookid,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
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
      isEdited = await editBook(bookid, editBookData);
      closeProgress(scaffoldKey);
      if (isEdited == "true") {
        isbnNo.clear();
        bookName.clear();
        authorName.clear();
        pubName.clear();
        mrpPrice.clear();
        price.clear();
        bookCatgName.clear();
        // postedBookEditModel.bookName.clear();
        // postedBookEditModel.bookName.clear();
        Navigator.pushNamedAndRemoveUntil(
            context, 'home', (Route<dynamic> route) => false);
        showFlutterToast("Book Edit Successfully");
        formKey.currentState.reset();
        return true;
      } else if (isEdited == null || isEdited == "") {
        showFlutterToast("Please fill the form correctly");
        return false;
      } else {
        showFlutterToast("Somthing went wrong Please try again");
        return false;
      }
    } else {
      changeAutoValidate();
      return false;
    }
  }

  chooseImage() async {
    file = await FilePicker.getFile(type: fileType);
    // file.then((value) {
    //   isImageSelected = "Image is Selected";
    // });

    notifyChange();
    setStatus('');
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

    String fileName = tmpFile.path.split('/').last;
    // print(fileName);
    extn = fileName.split(".");
    notifyChange();
  }

  // give book whole detail according to ID and show it into book detail page
  getStudentDetail(int id) async {
    _student = await getStudentById(id);
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

      var parsed = await updateImagePhoto(imageUpdateById);
      // closeProgress(scaffoldKey);
      if (parsed == "Success") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (Route<dynamic> route) => false,
        );
        showFlutterToast("Book Image updated successfully");
        formKey.currentState.reset();
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
    notifyChange();
    if (isSelected) {
      return true;
    } else {
      return false;
    }
  }

  setStatusList(String message) {
    status = message;
    notifyChange();
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
    notifyChange();
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

            String isPosted = await addImageList(body);
            // closeProgress(scaffoldKey);
            if (isPosted == "Success") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'home',
                (Route<dynamic> route) => false,
              );
              showFlutterToast("Book Posted Successfully");
              formKey.currentState.reset();
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
    notifyChange();
  }
}
