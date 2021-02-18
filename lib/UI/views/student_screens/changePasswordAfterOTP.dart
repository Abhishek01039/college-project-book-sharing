// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:hive/hive.dart';

class ChangePasswordAfterOTP extends StatelessWidget {
  static final tag = RoutePaths.ChangePasswordAfterOTP;
  final box = Hive.box("Student");
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentEditModel>(
      builder: (context, studentEditModel, child) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Change Password"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: ChangePasswordAfterOTPForm(
                scaffoldKey: scaffoldKey,
                studentEditModel: studentEditModel,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChangePasswordAfterOTPForm extends StatelessWidget {
  const ChangePasswordAfterOTPForm(
      {Key key, this.studentEditModel, this.scaffoldKey})
      : super(key: key);

  final StudentEditModel studentEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: studentEditModel.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      key: studentEditModel.changePassowdForm,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/undraw_forgot_password_gi2d.svg",
              width: 250,
              // color: Color(0xFF313457),
              allowDrawingOutsideViewBox: true,
              // fit: BoxFit.fill,
              height: 250,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: studentEditModel.passwordAfterOTP,
              decoration: const InputDecoration(
                hintText: "New Password",
                suffixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter New Password';
                } else if (value.length < 5) {
                  return 'Password must be more than five characters';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: studentEditModel.confirmPasswordAfterOTP,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                suffixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Confirm Password';
                } else if (value != studentEditModel.passwordAfterOTP.text) {
                  return 'Password is not same';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () {
                studentEditModel.updatePasswordProvider(context, scaffoldKey);
              },
              child: Text(
                "Change Password",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
