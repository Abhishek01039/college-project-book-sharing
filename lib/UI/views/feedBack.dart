import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedBack extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final tag = 'feedback';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Feed Back"),
      ),
      body: Consumer<StudentRegModel>(
        builder: (context, studentRegModel, _) {
          return Form(
            key: studentRegModel.feedbackFormKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: studentRegModel.feedBackEmail,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: studentRegModel.feedBackMessage,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await studentRegModel.feedBack(context, scaffoldKey);
                    },
                    child: Text("Send Message"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
