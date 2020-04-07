import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static final tag = "profile";
  Future<Student> getstudent() async {
    Api api = locator<Api>();
    Student student = await api.getStudentById(SPHelper.getInt('ID'));
    return student;
  }

  @override
  Widget build(BuildContext context) {
    // Student student = getstudent();
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getstudent(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                  "http://192.168.43.182:8000" +
                                      snapshot.data.photo.toLowerCase()),
                            ),
                          ),
                        ),
                        listView(snapshot.data),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      )),
    );
  }
}
