import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FeedBack extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final tag = RoutePaths.Feedback;

  @override
  Widget build(BuildContext context) {
    StudentRegModel _studentRegModel = Provider.of(context);
    _studentRegModel.feedBackEmail.text =
        _studentRegModel.box.get("email", defaultValue: "");
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Feed Back"),
      ),
      body: Consumer<StudentRegModel>(
        builder: (context, studentRegModel, _) {
          return SingleChildScrollView(
              child: FeedBackForm(
            scaffoldKey: scaffoldKey,
            studentRegModel: studentRegModel,
          ));
        },
      ),
    );
  }
}

class FeedBackForm extends StatelessWidget {
  const FeedBackForm({Key key, this.studentRegModel, this.scaffoldKey})
      : super(key: key);

  final StudentRegModel studentRegModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: studentRegModel.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      key: studentRegModel.feedbackFormKey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/undraw_anonymous_feedback_y3co.svg",
              width: 250,
              semanticsLabel: 'Acme Logo',
              // color: Color(0xFF313457),
              allowDrawingOutsideViewBox: true,
              // fit: BoxFit.fill,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: studentRegModel.feedBackEmail,
              decoration: const InputDecoration(
                hintText: "Enter Email",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Email';
                } else if (!isEmail(value)) {
                  return 'email invalid';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: studentRegModel.feedBackMessage,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: "Enter Message",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Message';
                }
                return null;
              },
              // maxLength: 2s

              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () async {
                await studentRegModel.feedBackProvider(context, scaffoldKey);
              },
              child: Text("Send Message"),
            ),
          ],
        ),
      ),
    );
  }
}
