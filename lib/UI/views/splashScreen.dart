import 'dart:async';

import 'package:booksharing/UI/views/homeScreen.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:flutter/material.dart';

class MySpalshScreen extends StatefulWidget {
  @override
  _MySpalshScreenState createState() => _MySpalshScreenState();
}

class _MySpalshScreenState extends State<MySpalshScreen>
    with WidgetsBindingObserver {
//ProgressDialog pr;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // SPHelper.logout();
    Timer(Duration(seconds: 3), () {
      // navigating to Home Screen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
      // SPHelper.setInt("DarkTheme", 0);
      SPHelper.getString("enrollmentNo").isEmpty
          ? Navigator.pushReplacementNamed(context, 'login')
          : Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    child: Hero(
                      tag: "Logo",
                      child: Image.asset(
                        "assets/book_logo.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("book sharing".toUpperCase()),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
