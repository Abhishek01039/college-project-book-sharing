import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/viewModels/studentLogInModel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  static final tag = 'login';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
      builder: (context, studentModel, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? ProtraitModeLogInPage(
                scaffoldKey: scaffoldKey,
                studentModel: studentModel,
              )
            : LandScapeModeLogInPage(
                scaffoldKey: scaffoldKey,
                studentModel: studentModel,
              );
      },
    );
  }
}

class LandScapeModeLogInPage extends StatelessWidget {
  const LandScapeModeLogInPage({
    Key key,
    @required this.scaffoldKey,
    @required this.studentModel,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StudentModel studentModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Center(
                    child: ClipRRect(
                      child: Hero(
                        tag: "Logo",
                        child: Image.asset(
                          'assets/book_logo.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                LandScapeLogInForm(
                  scaffoldKey: scaffoldKey,
                  studentModel: studentModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProtraitModeLogInPage extends StatelessWidget {
  const ProtraitModeLogInPage({
    Key key,
    @required this.scaffoldKey,
    @required this.studentModel,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StudentModel studentModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Center(
                    child: ClipRRect(
                      child: Hero(
                        tag: "Logo",
                        child: Image.asset('assets/book_logo.jpg'),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                PotraitLogInForm(
                  scaffoldKey: scaffoldKey,
                  studentModel: studentModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PotraitLogInForm extends StatelessWidget {
  const PotraitLogInForm({
    Key key,
    @required this.scaffoldKey,
    @required this.studentModel,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StudentModel studentModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Stack(
            //   children: <Widget>[
            //     Positioned(
            //       top: 10,
            //       left: 20,
            //       child: Icon(Icons.arrow_back_ios),
            //     ),
            //   ],
            // ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Icon(Icons.arrow_back_ios),
            //   ),
            // ),

            SizedBox(
              height: 10,
            ),
            Text(
              "Log In",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: studentModel.username,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: "Enrollment Number",
                suffixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Enrollement Number';
                }
                return null;
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: studentModel.pass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: Icon(Icons.lock_open),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () async {
                bool val = await studentModel.logIn(scaffoldKey);
                if (val) {
                  studentModel.username.clear();
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  showFlutterToast("Invalid Enrollment Number or Password");
                }
                // studentModel.username.clear();
                studentModel.pass.clear();
              },
              child: Container(
                width: double.infinity,
                child: Text(
                  "Log In",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Don't have an Account"),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'registration');
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LandScapeLogInForm extends StatelessWidget {
  const LandScapeLogInForm({
    Key key,
    @required this.scaffoldKey,
    @required this.studentModel,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StudentModel studentModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Stack(
                //   children: <Widget>[
                //     Positioned(
                //       top: 10,
                //       left: 20,
                //       child: Icon(Icons.arrow_back_ios),
                //     ),
                //   ],
                // ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Icon(Icons.arrow_back_ios),
                //   ),
                // ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Log In",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: studentModel.username,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: "Enrollment Number",
                    suffixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Enrollement Number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: studentModel.pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: Icon(Icons.lock_open),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: () async {
                    bool val = await studentModel.logIn(scaffoldKey);
                    if (val) {
                      studentModel.username.clear();
                      Navigator.pushReplacementNamed(context, 'home');
                    } else if (val == null) {
                    } else {
                      showFlutterToast("Invalid Enrollment Number or Password");
                    }
                    // studentModel.username.clear();
                    studentModel.pass.clear();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Log In",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Don't have an Account"),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'registration');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
