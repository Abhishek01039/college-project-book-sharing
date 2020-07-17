import 'dart:developer';

import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/book_screens/bookDelete.dart';
import 'package:booksharing/UI/views/book_screens/bookEdit.dart';
import 'package:booksharing/core/constant/app_constant.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/book_provider/bookEditModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// const double _fabDimension = 56.0;

class MyPostedBookDetail extends StatelessWidget {
  static final tag = RoutePaths.MyPostedBookDetail;
  final Book book;
  // final ContainerTransitionType _transitionType =
  //     ContainerTransitionType.fadeThrough;

  const MyPostedBookDetail({Key key, this.book})
      : assert(book != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = Hive.box("DarkTheme");

    PostedBookEditModel postedBookEditModel = Provider.of(context);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    _showImageDialog(PostedBookEditModel postedBookEditModel, BuildContext con,
        String image, int count, GlobalKey<ScaffoldState> _key) {
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text("Book Image"),
                scrollable: true,
                content: Stack(
                  children: <Widget>[
                    postedBookEditModel.file == null
                        ? FadeInImage(
                            fit: BoxFit.fitWidth,

                            // height: double.infinity,
                            // width: double.infinity,
                            placeholder: AssetImage("assets/book_logo.jpg"),
                            image: image.startsWith("http")
                                // image: image.startsWith("https://")
                                ? NetworkImage(
                                    image,
                                    // fit: BoxFit.fill,
                                  )
                                : NetworkImage(
                                    // "https://booksharingappdjango.herokuapp.com" +
                                    "http://192.168.43.182:8000" + image,
                                    // fit: BoxFit.fill,
                                  ),
                          )
                        : Image.file(
                            postedBookEditModel.file,
                            fit: BoxFit.fill,
                          ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color:
                            darkTheme.get("darkTheme", defaultValue: false) ==
                                    false
                                ? Colors.black87
                                : Color(0xFF313457),
                        height: 40,
                        // width: ,
                        // width: 250,
                        // color: Colors.black45,
                        child: InkWell(
                          onTap: () async {
                            // studented
                            // studentEditModel.updateStudentPhoto(context);
                            await postedBookEditModel.chooseImage();
                            setState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      postedBookEditModel.file = null;
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, 'bookdelete');

                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BookDelete(
                      //       bookId: bookId,
                      //     ),
                      //   ),
                      // );
                      // postedBookModel.deleteBookByTransaction(
                      //     context, bookId, scaffoldKey);
                      postedBookEditModel.updateImage(
                          con, book.bookName, book.bookId, count, _key);
                    },
                    child: Text("Yes"),
                  )
                ],
              );
            },
          );
        },
      );
    }

    // Student student = locator<Student>();
    // BookDetailModel bookDetailModel = Provider.of(context);
    // student = bookDetailModel.getStudentDetail(book.postedBy);
    // Widget getUserData(){
    //   return  ;
    // }
    // BookDetailModel bookDetailModel = Provider.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: PostedBookAppBar(
        book: book,
        scaffoldKey: scaffoldKey,
        postedBookEditModel: postedBookEditModel,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              // this is carousel of book image
              // Text("If you want to change the image then click on the photo/")
              book.bookImage.length != 0
                  ? CarouselSlider(
                      height: 300,
                      autoPlayCurve: Curves.easeIn,

                      pauseAutoPlayOnTouch: Duration(seconds: 10),
                      items: book.bookImage
                          .asMap()
                          .map(
                            (e, v) {
                              return MapEntry(
                                e,
                                InkWell(
                                  onTap: () {
                                    // print(e);
                                    _showImageDialog(postedBookEditModel,
                                        context, v.image, e, scaffoldKey);
                                  },
                                  child: FadeInImage(
                                    placeholder:
                                        AssetImage("assets/book_logo.jpg"),
                                    image: v.image.startsWith("http://")
                                        ? NetworkImage(
                                            v.image,
                                            // fit: BoxFit.fill,
                                          )
                                        : NetworkImage(
                                            // "https://booksharingappdjango.herokuapp.com" +

                                            "http://192.168.43.182:8000" +
                                                v.image,
                                            // fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              );
                            },
                          )
                          .values
                          .toList(),
                      aspectRatio: 16 / 9,
                      autoPlay: true,

                      viewportFraction: 1.0,
                      // reverse: true,
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  book.bookName,
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("BY" + "  " + book.authorName),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("MRP  :"),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "₹" + "   " + book.originalPrice.toString(),
                    // style: TextStyle(color: Colors.red),
                    style: orginialpriceStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text("Price  :"),
                  SizedBox(
                    width: 30,
                  ),
                  book.price == 0
                      ? Text(
                          "Free",
                          style: freePrice,
                        )
                      : Text(
                          "₹" + "   " + book.price.toString(),
                          // style: TextStyle(color: Colors.red),
                          style: freePrice,
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Features & Details",
                    style: headerStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text("Publisher Name  :"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(book.pubName)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("ISBN Number  :"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(book.isbnNo)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Book Category  :"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(book.bookCatgName)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Posted Date  :"),
                  // Text(book.pos)
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("yMMMMd").format(
                      DateTime.parse(book.postedDate),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Posted Time  :"),
                  // Text(book.pos)
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("j").format(
                      DateTime.parse(book.postedDate),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("posted By"),
                  Text("You")
                  // this ensure that perticular book posted by whom
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: OpenContainer(
      //   transitionDuration: Duration(seconds: 1),

      //   transitionType: _transitionType,
      //   openBuilder: (BuildContext context, VoidCallback action) {
      //     return BookEdit(
      //       book: book,
      //     );
      //     // return Navigator.of(context).pushNamed(context, "routeName");
      //   },
      //   closedElevation: 6.0,
      //   closedShape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(_fabDimension / 2),
      //     ),
      //   ),
      //   // closedColor: Theme.of(context).colorScheme.secondary,
      //   closedBuilder: (BuildContext context, VoidCallback openContainer) {
      //     return Material(
      //       type: MaterialType.transparency,
      //       child: Container(
      //         color:
      //             Theme.of(context).floatingActionButtonTheme.backgroundColor,
      //         child: SizedBox(
      //           height: _fabDimension,
      //           width: _fabDimension,
      //           child: Center(
      //             child: Icon(
      //               Icons.edit,
      //               color: Theme.of(context).colorScheme.onSecondary,
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookEdit(
                book: book,
              ),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class PostedBookAppBar extends StatelessWidget implements PreferredSize {
  final dynamic postedBookEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Book book;

  const PostedBookAppBar({
    Key key,
    this.postedBookEditModel,
    this.scaffoldKey,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Book Sharing",
        // style: textStyle,
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () async {
        //     // final RenderBox box = context.findRenderObject();
        //     // Share.share(
        //     //   book.bookImage[0].image,
        //     //   // subject: subject,
        //     //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        //     // );
        //     await postedBookEditModel.updateBookImageList(
        //         context, scaffoldKey, book.bookId, book.bookName);
        //   },
        // )

        PopupMenuButton(
          padding: EdgeInsets.only(right: 30, bottom: 30, left: 30),
          onCanceled: () {
            log("cancel Pop up menu");
          },
          onSelected: (value) async {
            if (value == 1) {
              await postedBookEditModel.updateBookImageList(
                  context, scaffoldKey, book.bookId, book.bookName);
            } else if (value == 2) {
              // _deleteBook(book.bookId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDelete(
                    bookId: book.bookId,
                  ),
                ),
              );
            }
          },
          offset: Offset(0, 0),
          child: Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add Book Image"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Delete"),
                  ],
                ),
              ),
            ];
          },
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => throw UnimplementedError();
}
