import 'package:booksharing/core/models/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget listView(Student student) {
  return ListView(
    shrinkWrap: true,
    primary: false,
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.confirmation_number),
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
        leading: FaIcon(
          FontAwesomeIcons.graduationCap,
          color: Colors.red,
        ),
        title: Text("College Name"),
        subtitle: Text(student.collegeName),
      ),
      ListTile(
        leading: FaIcon(
          FontAwesomeIcons.graduationCap,
          color: Colors.red,
        ),
        title: Text("College Year"),
        subtitle: Text(student.collegeYear.toString()),
      ),
      ListTile(
        leading: FaIcon(
          FontAwesomeIcons.graduationCap,
          color: Colors.red,
        ),
        title: Text("College Course"),
        subtitle: Text(student.course.toString()),
      ),
      ListTile(
        leading: FaIcon(
          FontAwesomeIcons.addressBook,
          color: Colors.red,
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
