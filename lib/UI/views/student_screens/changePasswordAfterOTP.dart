// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:hive/hive.dart';

class ChangePasswordAfterOTP extends StatelessWidget {
  static final tag = "changePasswordAfterOTP";
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
              child: Form(
                key: studentEditModel.changePassowdForm,
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
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: studentEditModel.passwordAfterOTP,
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Confirm Password';
                          } else if (value !=
                              studentEditModel.passwordAfterOTP.text) {
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
                          // studentEditModel.changePasswordModel(
                          //     context, box.get("ID"), scaffoldKey);

                          studentEditModel.updatePassword(context, scaffoldKey);
                        },
                        child: Text(
                          "Change Password",
                          textAlign: TextAlign.center,
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
