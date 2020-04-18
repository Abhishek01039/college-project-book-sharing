import 'dart:async';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class MySpalshScreen extends StatefulWidget {
  @override
  _MySpalshScreenState createState() => _MySpalshScreenState();
}

class _MySpalshScreenState extends State<MySpalshScreen>
    with WidgetsBindingObserver {
//ProgressDialog pr;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // SPHelper.logout();
    checkConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();

    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus);
      if (_connectionStatus == ConnectivityResult.mobile ||
          _connectionStatus == ConnectivityResult.wifi) {
        Timer(Duration(seconds: 3), () {
          SPHelper.getString("enrollmentNo").isEmpty
              ? Navigator.pushReplacementNamed(context, 'login')
              : Navigator.pushReplacementNamed(context, 'home');
        });
      }else if(_connectionStatus == ConnectivityResult.none){
        showFlutterToast("Connect to Internet");
      }
    });
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
