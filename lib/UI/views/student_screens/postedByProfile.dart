import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/widgets/postedByProfileListView.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _makeEmail(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _makePhoneCall(String url) async {
  assert(url.isNotEmpty);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showFlutterToast("Can not Call");
  }
}

class PostedByProfilePage extends StatelessWidget {
  final Student student;
  static final tag = RoutePaths.PostedByProfile;
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
                        // "https://booksharingappdjango.herokuapp.com" +
                        "http://192.168.43.183:8000/media/" + student.photo,
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'mailButton',
              onPressed: () {
                _makeEmail("mailto:${student.email}");
              },
              child: Icon(Icons.email),
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              heroTag: 'CallBotton',
              onPressed: () {
                _makePhoneCall('tel:${student.contactNo}');
              },
              child: Icon(Icons.call),
            ),
          ],
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(),
                color: Theme.of(context).primaryColor,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(80),
                //   bottomRight: Radius.circular(80),
                // ),
              ),
            ),
            Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
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
                            // "https://booksharingappdjango.herokuapp.com" +
                            "http://192.168.43.183:8000/media/" + student.photo,
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
          ],
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'mailButtonPotrait',
            onPressed: () {
              _makeEmail("mailto:${student.email}");
            },
            child: Icon(Icons.email),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: 'callButtonPotrait',
            onPressed: () {
              _makePhoneCall('tel:${student.contactNo}');
            },
            child: Icon(Icons.call),
          ),
        ],
      ),
    );
  }
}
