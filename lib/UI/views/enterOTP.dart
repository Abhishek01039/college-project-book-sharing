import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EnterOTP extends StatelessWidget {
  static final tag = 'enterOTP';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Enter OTP"),
      ),
      body: Consumer<StudentEditModel>(builder: (context, studentEditMode, _) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Enter the varification code we just sent you on your email address.",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Icon(
                FontAwesomeIcons.paperPlane,
                // size: MediaQuery.of(context).size.width - 100,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              Form(
                key: studentEditMode.verifyOTPFrom,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: studentEditMode.oTP,
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: "OTP",
                          suffixIcon: Icon(Icons.vpn_key),
                        ),
                        onChanged: (val) {
                          studentEditMode.verifyOTP = int.tryParse(val);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      RaisedButton(
                        onPressed: () {
                          // if (studentEditMode.verifyOTPFrom.currentState
                          //     .validate()) {
                          studentEditMode.varifyEmail(context, scaffoldKey);
                          // }
                        },
                        child: Text(
                          "Verify OTP",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
