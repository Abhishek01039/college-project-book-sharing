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

class MyPostedBookDetail extends StatefulWidget {
  const MyPostedBookDetail({Key key, this.book})
      : assert(book != null),
        super(key: key);

  static final tag = RoutePaths.MyPostedBookDetail;
  final Book book;

  @override
  _MyPostedBookDetailState createState() => _MyPostedBookDetailState();
}

class _MyPostedBookDetailState extends State<MyPostedBookDetail> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final darkTheme = Hive.box("DarkTheme");

    PostedBookEditModel postedBookEditModel = Provider.of(context);

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
                            placeholder: AssetImage("assets/book_logo.jpg"),
                            image: image.startsWith("http")
                                ? NetworkImage(
                                    image,
                                  )
                                : NetworkImage(
                                    // "https://booksharingappdjango.herokuapp.com" +
                                    "http://192.168.43.183:8000" + image,
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
                        child: InkWell(
                          onTap: () async {
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
                      postedBookEditModel.updateImage(con, widget.book.bookName,
                          widget.book.bookId, count, _key);
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

    return Scaffold(
      key: scaffoldKey,
      appBar: PostedBookAppBar(
        book: widget.book,
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
              widget.book.bookImage.length != 0
                  ? CarouselSlider(
                      height: 300,
                      autoPlayCurve: Curves.easeIn,

                      pauseAutoPlayOnTouch: Duration(seconds: 10),
                      items: widget.book.bookImage
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

                                            "http://192.168.43.183:8000" +
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
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.book.bookName,
                  style: textStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("BY" + "  " + widget.book.authorName),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("MRP  :"),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "₹" + "   " + widget.book.originalPrice.toString(),
                    // style: TextStyle(color: Colors.red),
                    style: orginialpriceStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text("Price  :"),
                  const SizedBox(
                    width: 30,
                  ),
                  widget.book.price == 0
                      ? Text(
                          "Free",
                          style: freePrice,
                        )
                      : Text(
                          "₹" + "   " + widget.book.price.toString(),
                          // style: TextStyle(color: Colors.red),
                          style: freePrice,
                        ),
                ],
              ),
              const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text("Publisher Name  :"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.book.pubName)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("ISBN Number  :"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.book.isbnNo)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Book Category  :"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.book.bookCatgName)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Posted Date  :"),
                  // Text(book.pos)
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("yMMMMd").format(
                      DateTime.parse(widget.book.postedDate),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Posted Time  :"),
                  // Text(book.pos)
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("j").format(
                      DateTime.parse(widget.book.postedDate),
                    ),
                  )
                ],
              ),
              if (widget.book.edition != null)
                const SizedBox(
                  height: 20,
                ),
              if (widget.book.edition != null)
                Row(
                  children: <Widget>[
                    Text("Edition  :"),
                    // Text(book.pos)
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.book.edition.toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookEdit(
                book: widget.book,
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
  const PostedBookAppBar({
    Key key,
    this.postedBookEditModel,
    this.scaffoldKey,
    this.book,
  }) : super(key: key);

  final dynamic postedBookEditModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Book Sharing",
        // style: textStyle,
      ),
      actions: <Widget>[
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
                    const SizedBox(
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Delete"),
                  ],
                ),
              ),
            ];
          },
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
