// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/UI/views/student_screens/studentEdit.dart';
import 'package:booksharing/core/constant/app_constant.dart';

import 'package:booksharing/core/viewModels/bloc/profile_bloc.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/UI/widgets/profilePageList.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatelessWidget {
  static final tag = RoutePaths.Profile;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final darkTheme = Hive.box("DarkTheme");
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
    BlocProvider.of<ProfileBloc>(context).add(ProfileInitialEvent());
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          color:
              darkTheme.get("darkTheme") == false ? Colors.white : Colors.black,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileLoaded) {
                return Material(
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
                                  state.student.photo != null
                                      ? Hero(
                                          tag: 'studentPhoto',
                                          child: Container(
                                            width: 190.0,
                                            height: 190.0,
                                            foregroundDecoration: BoxDecoration(
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
                                                  // "https://booksharingappdjango.herokuapp.com" +
                                                  "http://192.168.43.183:8000/media/" +
                                                      state.student.photo,
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
                                          color: darkTheme.get("darkTheme") ==
                                                  false
                                              ? Color(0xFF313457)
                                              : Colors.teal[200],
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // studented
                                            studentEditModel
                                                .updateStudentPhotoProvider(
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
                                          student: state.student,
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
                          child: profilePagelistView(state.student),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
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
    BlocProvider.of<ProfileBloc>(context).add(ProfileInitialEvent());
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
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
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      // ProfileBloc.add(ProfileInitialEvent());
                      if (state is ProfileLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                      if (state is ProfileLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 8,
                              // height: 100,
                            ),
                            Stack(
                              children: <Widget>[
                                state.student.photo != null
                                    ? Container(
                                        width: 190.0,
                                        height: 190.0,
                                        foregroundDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          // borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Hero(
                                          tag: 'studentPhoto',
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/book_logo.jpg"),
                                              image: NetworkImage(
                                                // "https://booksharingappdjango.herokuapp.com" +
                                                "http://192.168.43.183:8000/media/" +
                                                    state.student.photo,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 190.0,
                                        height: 190.0,
                                        foregroundDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          // borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Hero(
                                          tag: 'studentPhoto',
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.asset(
                                                "assets/book_logo.jpg"),
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
                                        color:
                                            darkTheme.get("darkTheme") == false
                                                ? Color(0xFF313457)
                                                : Colors.teal[200],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // studented
                                          studentEditModel
                                              .updateStudentPhotoProvider(
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
                            profilePagelistView(state.student),
                            const SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentEdit(
                                      student: state.student,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Edit Profile"),
                            )
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
