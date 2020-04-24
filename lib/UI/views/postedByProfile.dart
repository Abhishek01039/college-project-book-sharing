import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showFlutterToast("Can not Call");
  }
}

class PostedByProfilePage extends StatelessWidget {
  final Student student;
  static final tag = "postedByProfile";
  const PostedByProfilePage({Key key, this.student}) : super(key: key);

  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override

  // it show the detail of student who posted the interested book
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? ProtraitModePostedByProfilePage(student: student)
        : LandScaprPostedByProfilePage(student: student);
  }
}

class LandScaprPostedByProfilePage extends StatelessWidget {
  const LandScaprPostedByProfilePage({
    Key key,
    @required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 190.0,
                  height: 190.0,
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    // borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage(
                      placeholder: AssetImage("assets/book_logo.jpg"),
                      image: NetworkImage(
                        "https://booksharingappdjango.herokuapp.com" +
                            student.photo,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                child: listView(student),
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _makePhoneCall('tel:${student.contactNo}');
          },
          child: Icon(Icons.call),
        ),
      ),
    );
  }
}

class ProtraitModePostedByProfilePage extends StatelessWidget {
  const ProtraitModePostedByProfilePage({
    Key key,
    @required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 190.0,
                    height: 190.0,
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                        placeholder: AssetImage("assets/book_logo.jpg"),
                        image: NetworkImage(
                          "https://booksharingappdjango.herokuapp.com" +
                              student.photo,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                listView(student),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _makePhoneCall('tel:${student.contactNo}');
          },
          child: Icon(Icons.call),
        ),
      ),
    );
  }
}
