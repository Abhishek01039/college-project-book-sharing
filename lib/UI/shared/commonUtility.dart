import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextStyle textStyle = TextStyle(
    fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);

TextStyle orginialpriceStyle =
    TextStyle(color: Colors.orange, decoration: TextDecoration.lineThrough);

TextStyle priceStyle = TextStyle(color: Colors.orange);

TextStyle headerStyle =
    TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold);

// TextStyle oTPStyle=TextStyle(fontSize: 25,fontStyle: FontStyle.italic,);

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

showProgress(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      duration: Duration(seconds: 30),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text(
            "Please wait ....",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}

closeProgress(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState.hideCurrentSnackBar();
}

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
