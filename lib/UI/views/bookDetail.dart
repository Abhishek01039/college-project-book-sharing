import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/bookEdit.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/bookDetailModel.dart';
import 'package:booksharing/UI/views/postedByProfile.dart';
import 'package:share/share.dart';

class BookDetail extends StatefulWidget {
  static final tag = 'bookDetail';
  final Book book;

  const BookDetail({Key key, this.book}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    // Student student = locator<Student>();
    // BookDetailModel bookDetailModel = Provider.of(context);
    // student = bookDetailModel.getStudentDetail(book.postedBy);
    // Widget getUserData(){
    //   return  ;
    // }
    // BookDetailModel bookDetailModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Sharing",
          // style: textStyle,
        ),
      ),
      body: Consumer<BookDetailModel>(
        builder: (context, bookDetailModel, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  // this is carousel of book image
                  widget.book.bookImage.length != 0
                      ? CarouselSlider(
                          height: 300,
                          items: widget.book.bookImage
                              .asMap()
                              .map(
                                (e, v) {
                                  return MapEntry(
                                    e,
                                    v.image.startsWith("http://")
                                        ? Image.network(v.image)
                                        : Image.network(
                                            "https://booksharingappdjango.herokuapp.com" +
                                                v.image.toLowerCase(),
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
                      widget.book.bookName,
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("BY" + "  " + widget.book.authorName),
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
                        "₹" + "   " + widget.book.originalPrice.toString(),
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
                      Text(
                        "₹" + "   " + widget.book.price.toString(),
                        // style: TextStyle(color: Colors.red),
                        style: priceStyle,
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
                      Text(widget.book.pubName)
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
                      Text(widget.book.isbnNo)
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
                      Text(widget.book.bookCatgName)
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
                      Text(DateTime.parse(widget.book.postedDate)
                          .toLocal()
                          .toString())
                    ],
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("posted By"),
                      // this ensure that perticular book posted by whom
                      FutureBuilder(
                        future: bookDetailModel
                            .getStudentDetail(widget.book.postedBy),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.enrollmentNo !=
                                SPHelper.getString('enrollmentNo')) {
                              return GestureDetector(
                                child: Text(
                                  snapshot.data.firstName,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostedByProfilePage(
                                        student: snapshot.data,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              // setState(() {

                              return Row(
                                children: <Widget>[
                                  Text("You"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  OutlineButton(
                                    // icon: Icon(Icons.edit),
                                    child: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookEdit(
                                            book: widget.book,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
