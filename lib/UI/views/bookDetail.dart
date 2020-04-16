import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/bookDetailModel.dart';
import 'package:booksharing/UI/views/postedByProfile.dart';

class BookDetail extends StatelessWidget {
  static final tag = 'bookDetail';
  final Book book;

  const BookDetail({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Student student = locator<Student>();
    BookDetailModel bookDetailModel = Provider.of(context);
    // student = bookDetailModel.getStudentDetail(book.postedBy);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Sharing",
          // style: textStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              // this is carousel of book image
              book.bookImage.length != 0
                  ? CarouselSlider(
                      items: book.bookImage.map(
                        (e) {
                          if (e.image.startsWith("http://"))
                            return Image.network(e.image);
                          else
                            return Image.network("http://192.168.43.182:8000" +
                                e.image.toLowerCase());
                        },
                      ).toList(),
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
                  Text(
                    "₹" + "   " + book.price.toString(),
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
                  Text(DateTime.parse(book.postedDate).toLocal().toString())
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
                    future: bookDetailModel.getStudentDetail(book.postedBy),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? snapshot.data.enrollmentNo !=
                                  SPHelper.getString('enrollmentNo')
                              ? GestureDetector(
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
                                        builder: (context) =>
                                            PostedByProfilePage(
                                          student: snapshot.data,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Text("You")
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
