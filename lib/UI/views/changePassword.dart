import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/studentRegModel.dart';

class ChangePassword extends StatelessWidget {
  static final tag = "changePassword";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentRegModel>(
      builder: (context, studentModel, child) {
        return Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: studentModel.changePassformKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: studentModel.changePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Old Password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: studentModel.changeNewPassword,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter New Password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: studentModel.changeNewConfirmPassword,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Confirm Password';
                          } else if (value !=
                              studentModel.changeNewPassword.text) {
                            return 'Password is not same';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RaisedButton(
                        onPressed: () {
                          studentModel.changePasswordModel(
                              context, SPHelper.getInt("ID"), scaffoldKey);
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Change Password",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
