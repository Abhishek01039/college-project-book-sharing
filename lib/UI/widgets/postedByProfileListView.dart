import 'package:booksharing/core/models/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Widget listView(Student student) {
  Future<void> _makeEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return ListView(
    shrinkWrap: true,
    primary: false,
    children: <Widget>[
      // ListTile(
      //   leading: Icon(FontAwesomeIcons.university),
      //   title: Text("Enrollment Number"),
      //   subtitle: Text(student.em),
      // ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Name"),
        subtitle: Text(student.firstName + "  " + student.lastName),
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text("Email"),
        subtitle: Text(student.email),
        onTap: () {
          _makeEmail("mailto:${student.email}");
        },
      ),
      // ListTile(
      //   leading: Icon(
      //     Icons.domain,
      //   ),
      //   title: Text("College Name"),
      //   subtitle: Text(student.collegeName),
      // ),
      // ListTile(
      //   leading: Icon(
      //     Icons.import_contacts,
      //   ),
      //   title: Text("College Year"),
      //   subtitle: Text(student.collegeYear.toString()),
      // ),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.graduationCap,
        ),
        title: Text("Age"),
        subtitle: Text(student.age.toString()),
      ),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.addressBook,
        ),
        title: Text("Address"),
        subtitle: Text(student.address),
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text("Contact Number"),
        subtitle: Text(student.contactNo),
      ),
    ],
  );
}
