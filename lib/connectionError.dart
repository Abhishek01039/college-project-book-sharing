import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Image.asset(
                "assets/no_internet_conenction.png",
                fit: BoxFit.cover,
              ),
              Text('Connect to Internet'),
            ],
          ),
        ),
      );
    },
  );
}
