import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/UI/views/studentEdit.dart';
import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    StudentEditModel studentEditModel = Provider.of(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Positioned(
              left: 20,
              top: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: getstudent(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? Stack(
                            children: [
                              Positioned(
                                right: 20,
                                // top: 20,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StudentEdit(
                                          student: snapshot.data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Container(
                                  //   height:
                                  //       MediaQuery.of(context).size.height / 3,
                                  //   child: Stack(
                                  //     children: [
                                  //       Center(
                                  //         child: ClipRRect(
                                  //           borderRadius:
                                  //               BorderRadius.circular(32),
                                  //           child: Image.network(
                                  //             "http://192.168.43.182:8000" +
                                  //                 snapshot.data.photo
                                  //                     .toLowerCase(),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Positioned(
                                  //         // width: double.infinity,
                                  //         bottom: 0,
                                  //         left: MediaQuery.of(context).size.width/3,

                                  //         child: Center(
                                  //           child: Container(

                                  //             color: Colors.red,
                                  //             child: Icon(Icons.edit),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 190.0,
                                        height: 190.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                              "http://192.168.43.182:8000" +
                                                  snapshot.data.photo
                                                      .toLowerCase(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        // left: 80,
                                        child: Center(
                                          child: Container(
                                            width: 190,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                // studented
                                                studentEditModel
                                                    .updateStudentPhoto(
                                                        context);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  listView(snapshot.data),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
