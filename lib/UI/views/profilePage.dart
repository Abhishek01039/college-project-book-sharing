// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/UI/views/studentEdit.dart';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/UI/widgets/profilePageList.dart';
import 'package:hive/hive.dart';

final box = Hive.box("Student");
Future<Student> getstudent() async {
  Api api = locator<Api>();
  Student student = await api.getStudentById(box.get("ID"));
  return student;
}

class ProfilePage extends StatelessWidget {
  static final tag = "profile";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final darkTheme = Hive.box("DarkTheme");
    // Student student = getstudent();
    StudentEditModel studentEditModel = Provider.of(context);
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? PotraitModeProfilePage(
            scaffoldKey: scaffoldKey,
            darkTheme: darkTheme,
            studentEditModel: studentEditModel)
        : LandscapeModeProfilePage(
            darkTheme: darkTheme,
            studentEditModel: studentEditModel,
            scaffoldKey: scaffoldKey,
          );
  }
}

class LandscapeModeProfilePage extends StatelessWidget {
  const LandscapeModeProfilePage({
    Key key,
    @required this.darkTheme,
    @required this.studentEditModel,
    @required this.scaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Box darkTheme;
  final StudentEditModel studentEditModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          color:
              darkTheme.get("darkTheme") == false ? Colors.white : Colors.black,
          child: FutureBuilder(
            future: getstudent(),
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Material(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Stack(
                                    children: <Widget>[
                                      snapshot.data.photo != null
                                          ? Hero(
                                              tag: 'studentPhoto',
                                              child: Container(
                                                width: 190.0,
                                                height: 190.0,
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  // borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: FadeInImage(
                                                    placeholder: AssetImage(
                                                        "assets/book_logo.jpg"),
                                                    image: NetworkImage(
                                                      "https://booksharingappdjango.herokuapp.com" +
                                                          snapshot.data.photo,
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : AssetImage("assets/book_logo.jpg"),
                                      Positioned(
                                        bottom: 0,
                                        // left: 80,
                                        child: Center(
                                          child: Container(
                                            width: 190,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  darkTheme.get("darkTheme") ==
                                                          false
                                                      ? Color(0xFF313457)
                                                      : Colors.teal[200],
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
                                                        context, scaffoldKey);
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
                                                  const SizedBox(
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
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StudentEdit(
                                              student: snapshot.data,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text("Edit Profile"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: profilePagelistView(snapshot.data),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class PotraitModeProfilePage extends StatelessWidget {
  const PotraitModeProfilePage({
    Key key,
    @required this.darkTheme,
    @required this.studentEditModel,
    @required this.scaffoldKey,
  }) : super(key: key);

  final Box darkTheme;
  final StudentEditModel studentEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(),
                color: Theme.of(context).primaryColor,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(80),
                //   bottomRight: Radius.circular(80),
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      FutureBuilder(
                        future: getstudent(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            snapshot.data.photo != null
                                                ? Container(
                                                    width: 190.0,
                                                    height: 190.0,
                                                    foregroundDecoration:
                                                        BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      // borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Hero(
                                                      tag: 'studentPhoto',
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: FadeInImage(
                                                          placeholder: AssetImage(
                                                              "assets/book_logo.jpg"),
                                                          image: NetworkImage(
                                                            "https://booksharingappdjango.herokuapp.com" +
                                                                snapshot
                                                                    .data.photo,
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : AssetImage(
                                                    "assets/book_logo.jpg"),
                                            Positioned(
                                              bottom: 0,
                                              // left: 80,
                                              child: Center(
                                                child: Container(
                                                  width: 190,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: darkTheme.get(
                                                                "darkTheme") ==
                                                            false
                                                        ? Color(0xFF313457)
                                                        : Colors.teal[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      // studented
                                                      studentEditModel
                                                          .updateStudentPhoto(
                                                              context,
                                                              scaffoldKey);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const SizedBox(
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

                                        profilePagelistView(snapshot.data),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentEdit(
                                                  student: snapshot.data,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Edit Profile"),
                                        )
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
