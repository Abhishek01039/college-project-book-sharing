import 'package:booksharing/core/models/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget profilePagelistView(Student student) {
  return ListView(
    shrinkWrap: true,
    primary: false,
    children: <Widget>[
      ListTile(
        leading: Icon(FontAwesomeIcons.university),
        title: Text("Enrollment Number"),
        subtitle: Text(student.enrollmentNo),
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Name"),
        subtitle: Text(student.firstName + "  " + student.lastName),
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text("Email"),
        subtitle: Text(student.email),
      ),
      ListTile(
        leading: Icon(
          Icons.domain,
        ),
        title: Text("College Name"),
        subtitle: Text(student.collegeName),
      ),
      ListTile(
        leading: Icon(
          Icons.import_contacts,
        ),
        title: Text("College Year"),
        subtitle: Text(student.collegeYear.toString()),
      ),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.graduationCap,
        ),
        title: Text("College Course"),
        subtitle: Text(student.course.toString()),
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
