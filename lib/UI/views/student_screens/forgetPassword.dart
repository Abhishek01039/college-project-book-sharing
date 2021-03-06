import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

// import 'package:flutter_otp/flutter_otp.dart';
class ForgetPassword extends StatelessWidget {
  static final tag = RoutePaths.ForgetPassword;
  // final countryCode = "+91";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Consumer<StudentEditModel>(
        builder: (context, studentEditMode, _) {
          studentEditMode.emailOTP.clear();
          return SingleChildScrollView(
            child: ForgetPasswordForm(
              scaffoldKey: scaffoldKey,
              studentEditModel: studentEditMode,
            ),
          );
        },
      ),
    );
  }
}

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({Key key, this.studentEditModel, this.scaffoldKey})
      : super(key: key);

  final StudentEditModel studentEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: studentEditModel.sendOTPFrom,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              // height: MediaQuery.of(context).size.height / 1.2,
              width: double.infinity,
              height: 200,
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
                    "assets/svg/undraw_mail_2_tqip.svg",
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
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter email address associated with your account.",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  // controller: studentModel.username,
                  controller: studentEditModel.emailOTP,
                  // textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Email';
                    }
                    if (!isEmail(value)) {
                      return "Please enter valid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: () {
                    // if (studentEditMode.sendOTPFrom.currentState
                    //     .validate()) {
                    studentEditModel.sendEmailProvider(context, scaffoldKey);
                    // }
                  },
                  child: Text(
                    "Send OTP",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
