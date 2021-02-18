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
