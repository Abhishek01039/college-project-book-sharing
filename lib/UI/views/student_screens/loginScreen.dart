import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/student_provider/studentLogInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  static final tag = RoutePaths.Login;
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
                      // child: Hero(
                      //   tag: "Logo",
                      //   child: Image.asset(
                      //     'assets/book_logo.jpg',
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      child: SvgPicture.asset(
                        "assets/svg/undraw_Login_v483.svg",
                        width: 250,
                        // color: Color(0xFF313457),
                        allowDrawingOutsideViewBox: true,
                        // fit: BoxFit.fill,
                        height: 250,
                      ),
                      // borderRadius: BorderRadius.circular(20),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: MediaQuery.of(context).size.height / 2.5,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Center(
                    child: ClipRRect(
                      // child: Hero(
                      //   tag: "Logo",
                      //   // child: Image.asset('assets/book_logo.jpg'),
                      child: SvgPicture.asset(
                        "assets/svg/undraw_Login_v483.svg",
                        width: MediaQuery.of(context).size.width - 200,
                        // color: Color(0xFF313457),
                        allowDrawingOutsideViewBox: true,
                        // fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                      // ),
                      // borderRadius: BorderRadius.circular(20),
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
        autovalidateMode: studentModel.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        key: studentModel.formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: studentModel.username,
              decoration: const InputDecoration(
                hintText: "Email",
                suffixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Email Address';
                }
                if (!isEmail(value)) {
                  return "Please enter valid Email";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: studentModel.pass,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                suffixIcon: Icon(Icons.lock_open),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Password';
                } else if (value.length < 5) {
                  return 'Password must be more than five characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () async {
                if (studentModel.formKey.currentState.validate()) {
                  bool val = await studentModel.logInProvider(scaffoldKey);
                  if (val) {
                    studentModel.username.clear();
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    showFlutterToast("Invalid Email or Password");
                  }
                } else {
                  studentModel.changeAutoValidate();
                }
                // studentModel.username.clear();
                studentModel.pass.clear();
              },
              child: Text(
                "Log In",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.ForgetPassword);
              },
              child: Text(
                "Forget your password?",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Don't have an Account"),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.Register);
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
          autovalidateMode: studentModel.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: studentModel.formKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: studentModel.username,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    suffixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Email Address';
                    }
                    if (!isEmail(value)) {
                      return "Please enter valid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: studentModel.pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    suffixIcon: Icon(Icons.lock_open),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Password';
                    } else if (value.length < 5) {
                      return 'Password must be more than five characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (studentModel.formKey.currentState.validate()) {
                      bool val = await studentModel.logInProvider(scaffoldKey);
                      if (val) {
                        studentModel.username.clear();
                        Navigator.pushReplacementNamed(context, 'home');
                      } else if (val == null) {
                      } else {
                        showFlutterToast("Invalid Email or Password");
                      }
                      // studentModel.username.clear();
                    } else {
                      studentModel.changeAutoValidate();
                    }
                    studentModel.pass.clear();
                  },
                  child: Text(
                    "Log In",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.ForgetPassword);
                  },
                  child: Text(
                    "Forget your password?",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Don't have an Account"),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.Register);
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
