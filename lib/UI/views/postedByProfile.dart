import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showFlutterToast("Can not Call");
    }
  }

  @override

  // it show the detail of student who posted the interested book
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                        "http://192.168.43.182:8000" +
                            student.photo.toLowerCase(),
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
