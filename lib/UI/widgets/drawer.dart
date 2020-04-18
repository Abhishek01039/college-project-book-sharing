import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Student student = locator<Student>();
    // print(student.firstName);

    // print(SPHelper.getString("studentPhoto"));
    StudentEditModel studentEditModel = locator<StudentEditModel>();
    BaseModel baseModel = Provider.of(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      child: Drawer(
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
                accountName: SPHelper.getString("enrollmentNo").isEmpty
                    ? Text('Test123')
                    : Text(SPHelper.getString("enrollmentNo")),
                accountEmail: SPHelper.getString("studentName").isEmpty
                    ? Text('Test123')
                    : Text(SPHelper.getString("studentName")),
                // currentAccountPicture: CircleAvatar(
                //   foregroundColor: Colors.transparent,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(100),
                //     child: FittedBox(
                //       fit: BoxFit.fill,
                //       child: Image.network(
                //         SPHelper.getString("studentPhoto").isNotEmpty != null
                //             ? "http://192.168.43.182:8000/media/" +
                //                 SPHelper.getString("studentPhoto")
                //                     .toLowerCase()
                //             : Image.asset("assets/book_logo.jpg"),
                //         fit: BoxFit.fitWidth,
                //         matchTextDirection: true,
                //       ),
                //     ),
                //   ),
                // ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        SPHelper.getString("studentPhoto").isNotEmpty
                            ? "http://192.168.43.182:8000" +
                                SPHelper.getString("studentPhoto").toLowerCase()
                            : AssetImage("assets/book_logo.jpg"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'profile');
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.user),
                title: Text("Profile"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "changePassword");
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.key),
                title: Text("Change Password"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "postedBook");
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.book),
                title: Text("Post Your Book"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "myPostedBook");
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.bookOpen),
                title: Text("My Posted Book"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "myPurchasedBook");
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.shoppingBasket),
                title: Text("My Purchased Book"),
              ),
            ),
            InkWell(
              // onTap: () {
              //   baseModel.changeTheme();
              //   // print(baseModel.isDarkTheme);
              // },

              // switch theme
              child: ListTile(
                leading: Icon(FontAwesomeIcons.lightbulb),
                title: Text("Dark Theme"),
                trailing: Switch.adaptive(
                  value: SPHelper.getBool("DarkTheme"),
                  onChanged: (value) {
                    baseModel.changeTheme(value);
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'feedback');
              },
              child: ListTile(
                leading: Icon(Icons.feedback),
                title: Text("Feed Back"),
              ),
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
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () async {
                            await studentEditModel.deleteStudent(
                                context, SPHelper.getInt("ID"));
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
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            SPHelper.logout();
                            SPHelper.getString(SPHelper.enrollmentNo);
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationIcon: FlutterLogo(),
                  applicationName: 'Book Sharing',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2020 The Chromium Authors',
                  //  children: aboutBoxChildren,
                );
              },
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
