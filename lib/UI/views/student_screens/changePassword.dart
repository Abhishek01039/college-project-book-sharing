// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:booksharing/core/constant/app_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:hive/hive.dart';

class ChangePassword extends StatelessWidget {
  static final tag = RoutePaths.ChangePassword;
  final box = Hive.box("Student");
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentRegModel>(
      builder: (context, studentModel, child) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Change Password"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: ChangePasswordForm(
                box: box,
                scaffoldKey: scaffoldKey,
                studentModel: studentModel,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChangePasswordForm extends StatelessWidget {
  final StudentRegModel studentModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Box box;

  const ChangePasswordForm({
    Key key,
    this.studentModel,
    this.scaffoldKey,
    this.box,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: studentModel.changePassformKey,
      autovalidateMode: studentModel.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
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
              height: 20,
            ),
            TextFormField(
              controller: studentModel.changePasswordTextController,
              decoration: const InputDecoration(
                hintText: "Password",
                suffixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Old Password';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: studentModel.changeNewPassword,
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
              controller: studentModel.changeNewConfirmPassword,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                suffixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Confirm Password';
                } else if (value != studentModel.changeNewPassword.text) {
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
                studentModel.changePasswordModel(
                    context, box.get("ID"), scaffoldKey);
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
