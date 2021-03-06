import 'dart:async';
// import 'dart:html';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:booksharing/UI/shared/commonUtility.dart';

// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    final box = Hive.box("Student");

    WidgetsBinding.instance.addObserver(this);
    // SPHelper.logout();
    if (kIsWeb) {
      Timer(Duration(seconds: 3), () {
        // print(SPHelper.getString("enrollmentNo"));
        box.get("email") == null
            ? Navigator.pushReplacementNamed(context, 'login')
            : Navigator.pushReplacementNamed(context, 'home');
      });
    } else if (Platform.isAndroid || Platform.isIOS) {
      checkConnection();

      // channel.sink.add();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (!kIsWeb) {
      _connectivitySubscription.cancel();
    }

    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    final box = Hive.box("Student");
    setState(() {
      _connectionStatus = result;
      // print(_connectionStatus);

      if (_connectionStatus == ConnectivityResult.mobile ||
          _connectionStatus == ConnectivityResult.wifi) {
        Timer(Duration(seconds: 3), () {
          box.get("email") == null
              ? Navigator.pushReplacementNamed(context, 'login')
              : Navigator.pushReplacementNamed(context, 'home');
        });
      } else if (_connectionStatus == ConnectivityResult.none) {
        showFlutterToast("Connect to Internet");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? PotraitModesplashScreen()
        : SafeArea(
            child: Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Row(
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
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("book sharing".toUpperCase()),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class PotraitModesplashScreen extends StatelessWidget {
  const PotraitModesplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
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
      ),
    );
  }
}
