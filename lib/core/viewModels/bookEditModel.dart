import 'dart:convert';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:flutter/material.dart';

class PostedBookEditModel extends BaseModel{
  TextEditingController bookName = TextEditingController();
  TextEditingController isbnNo = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController pubName = TextEditingController();
  TextEditingController mrpPrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController bookCatgName = TextEditingController();
  TextEditingController studentName = TextEditingController();
  Api api = locator<Api>();
  bool isEdited;
  
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
        showFlutterToast("Please check internet connection");
      }

      showProgress(scaffoldKey);
    }
    isEdited = await api.editBook(bookid, editBookData);
    closeProgress(scaffoldKey);
  }

}