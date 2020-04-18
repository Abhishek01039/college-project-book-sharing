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
          return SingleChildScrollView(
            child: Form(
              key: studentRegModel.feedbackFormKey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  // mainAxisAlign`/ment: MainAxisAlignment.center,
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
                      textCapitalization: TextCapitalization.words,
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
            ),
          );
        },
      ),
    );
  }
}
