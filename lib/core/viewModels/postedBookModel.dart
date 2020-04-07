import 'dart:convert';
import 'dart:io';

import 'package:booksharing/core/viewModels/baseModel.dart';
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

  chooseBookImage() async {
    bookImages.clear();
    await FilePicker.getMultiFile(type: fileType).then((value) {
      for (var i in value) {
        bookImages.add(i);
      }
    });
    print(bookImages);
    startUpload();
    notifyListeners();
  }

  setStatus(String message) {
    status = message;
    notifyListeners();
  }

  startUpload() async {
    print("presseed");
    setStatus('Uploading Image...');
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

    notifyListeners();
  }
}
