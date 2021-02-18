import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class EnterOTP extends StatelessWidget {
  static final tag = RoutePaths.EnterOTP;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Enter OTP"),
      ),
      body: Consumer<StudentEditModel>(builder: (context, studentEditModel, _) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
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
              const SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                "assets/svg/undraw_Mail_sent_qwwx.svg",
                width: 80,
                // color: Color(0xFF313457),
                allowDrawingOutsideViewBox: true,
                // fit: BoxFit.fill,
                height: 80,
              ),
              EnterOTPForm(
                scaffoldKey: scaffoldKey,
                studentEditModel: studentEditModel,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class EnterOTPForm extends StatelessWidget {
  const EnterOTPForm({Key key, this.studentEditModel, this.scaffoldKey})
      : super(key: key);

  final StudentEditModel studentEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: studentEditModel.verifyOTPFrom,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: studentEditModel.oTP,
              keyboardType: TextInputType.phone,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: "OTP",
                suffixIcon: Icon(Icons.vpn_key),
              ),
              onChanged: (val) {
                studentEditModel.verifyOTP = int.tryParse(val);
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
                studentEditModel.varifyEmail(context, scaffoldKey);
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
    );
  }
}
