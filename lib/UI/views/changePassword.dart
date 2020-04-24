// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:hive/hive.dart';

class ChangePassword extends StatelessWidget {
  static final tag = "changePassword";
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
              child: Form(
                key: studentModel.changePassformKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/book_logo.jpg",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: studentModel.changePassword,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: studentModel.changeNewPassword,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
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
                        obscureText: true,
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
                              context, box.get("ID"), scaffoldKey);
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
