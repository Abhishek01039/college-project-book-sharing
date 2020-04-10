import 'dart:convert';
import 'dart:io';

import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class PostedBookModel extends BaseModel {
  TextEditingController bookName = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController pubName = TextEditingController();
  TextEditingController mrpPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bookCatgName = TextEditingController();
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
      print(fileName);
      print(base64Image);
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

  Future<bool> registeredBook() async {
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
    if (isPosted) {
      return true;
    }
    return false;
  }

  editBook(int bookid) async {
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
    isEdited= await api.editBook(bookid,editBookData);
  }
}
