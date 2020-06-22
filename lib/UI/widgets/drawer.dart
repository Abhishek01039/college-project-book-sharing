// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Student student = locator<Student>();
    // print(student.firstName);
    StudentRegModel _studentRegModel = Provider.of(context);
    // print(box.get('studentPhoto'));
    StudentEditModel studentEditModel = locator<StudentEditModel>();
    // var box = await Hive.openBox('Student');
    final box = Hive.box("Student");
    var darkTheme = Hive.box("DarkTheme");
    print(box.get('studentPhoto'));
    BaseModel baseModel = Provider.of(context);
    return Drawer(
      elevation: 20,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, 'profile');
            },
            child: UserAccountsDrawerHeader(
              arrowColor: Colors.red,
              accountName: box.get('email').isEmpty
                  ? Text('Test123')
                  : Text(box.get('email')),
              accountEmail: box.get('studentName').isEmpty
                  ? Text('Test123')
                  : Text(box.get('studentName')),
              // currentAccountPicture: CircleAvatar(
              //   foregroundColor: Colors.transparent,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(100),
              //     child: FittedBox(
              //       fit: BoxFit.fill,
              //       child: Image.network(
              //         box.get('studentPhoto').isNotEmpty != null
              //             ? "http://192.168.43.182:8000/media/" +
              //                 box.get('studentPhoto')
              //                     .toLowerCase()
              //             : Image.asset("assets/book_logo.jpg"),
              //         fit: BoxFit.fitWidth,
              //         matchTextDirection: true,
              //       ),
              //     ),
              //   ),
              // ),
              currentAccountPicture: box.get('studentPhoto') == null ||
                      box.get('studentPhoto') == "/media/" ||
                      box.get('studentPhoto') == ""
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/book_logo.jpg"),
                        ),
                      ),
                    )
                  : Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Hero(
                          tag: "studentPhoto",
                          child: FadeInImage(
                            placeholder: AssetImage("assets/book_logo.jpg"),
                            image: NetworkImage(
                              // "https://booksharingappdjango.herokuapp.com" +
                              "http://192.168.43.182:8000" +
                                  box.get("studentPhoto"),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                'profile',
              );
            },
            leading: Icon(FontAwesomeIcons.user),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "changePassword").then((value) {
                _studentRegModel.changePassformKey.currentState.reset();
              });
            },
            leading: Icon(FontAwesomeIcons.key),
            title: Text("Change Password"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "postedBook");
            },
            leading: Icon(FontAwesomeIcons.book),
            title: Text("Post Your Book"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "myPostedBook");
            },
            leading: Icon(FontAwesomeIcons.bookOpen),
            title: Text("My Posted Book"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "myPurchasedBook");
            },
            leading: Icon(FontAwesomeIcons.shoppingBasket),
            title: Text("My Purchased Book"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.lightbulb),
            title: Text("Dark Theme"),
            trailing: ValueListenableBuilder(
              valueListenable: Hive.box("DarkTheme").listenable(),
              builder: (context, box, widget) {
                return Switch.adaptive(
                  value: darkTheme.get("darkTheme", defaultValue: false),
                  onChanged: (value) {
                    baseModel.changeTheme(value);
                  },
                );
              },
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'feedback');
            },
            leading: Icon(Icons.feedback),
            title: Text("Feed Back"),
          ),
          InkWell(
            onTap: () async {
              // ensure that you really want to delete Account
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Do you want to Delete Account"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          await studentEditModel.deleteStudentProvider(
                              context, box.get('ID'));
                        },
                      ),
                    ],
                  );
                },
              );
              // Navigator.pop(context);
              // SPHelper.logout();

              // Navigator.pushNamed(context, "myPostedBook");
            },
            child: ListTile(
              leading: Icon(FontAwesomeIcons.userTimes),
              title: Text("Delete Account"),
            ),
          ),
          InkWell(
            onTap: () {
              // ensure that you really want to log out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Do you want to Log Out"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          box.clear();
                          box.get('enrollmentNo');
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'login', (route) => false);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationIcon: FlutterLogo(
                  textColor: Colors.green,
                  size: 50,
                ),
                applicationName: 'Book Sharing',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2020 The Chromium Authors',
                //  children: aboutBoxChildren,
              );
            },
            leading: Icon(Icons.info),
            title: Text("About"),
          )
        ],
      ),
    );
  }
}
