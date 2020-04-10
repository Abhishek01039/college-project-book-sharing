import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextStyle textStyle = TextStyle(
    fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);

TextStyle orginialpriceStyle =
    TextStyle(color: Colors.orange, decoration: TextDecoration.lineThrough);

TextStyle priceStyle = TextStyle(color: Colors.orange);

TextStyle headerStyle =
    TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);

showFlutterToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
