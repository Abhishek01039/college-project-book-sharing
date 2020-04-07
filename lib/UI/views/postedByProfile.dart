import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostedByProfilePage extends StatelessWidget {
  final Student student;
  static final tag = "postedByProfile";
  const PostedByProfilePage({Key key, this.student}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.network("http://192.168.43.182:8000" +
                          student.photo.toLowerCase()),
                    ),
                  ),
                ),
                listView(student),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
