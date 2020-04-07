import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Student student = locator<Student>();
    // print(student.firstName);

    return SafeArea(
      child: Container(
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
                    // width: MediaQuery.of(context).size.width,
                    // height: 100,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          SPHelper.getString("studentPhoto").isNotEmpty != null
                              ? "http://192.168.43.182:8000/media/" +
                                  SPHelper.getString("studentPhoto")
                                      .toLowerCase()
                              : Image.asset("assets/book_logo.jpg"),
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
                  leading: FaIcon(FontAwesomeIcons.user),
                  title: Text("Profile"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "postedBook");
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.book),
                  title: Text("Post Your Book"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "myPostedBook");
                },
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.bookOpen),
                  title: Text("My Posted Book"),
                ),
              ),
              InkWell(
                onTap: () {
                  SPHelper.logout();
                  SPHelper.getString(SPHelper.enrollmentNo);
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Log Out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
