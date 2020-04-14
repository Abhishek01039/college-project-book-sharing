import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/postedBookModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookEdit extends StatelessWidget {
  static final tag = "postedBook";
  final Book book;

  BookEdit({Key key, this.book}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    PostedBookModel postedBookModel = Provider.of(context);
    postedBookModel.bookName.text = book.bookName;
    postedBookModel.isbnNo.text = book.isbnNo;
    postedBookModel.authorName.text = book.authorName;
    postedBookModel.pubName.text = book.pubName;
    postedBookModel.mrpPrice.text = book.originalPrice.toString();
    postedBookModel.price.text = book.price.toString();
    postedBookModel.bookCatgName.text = book.bookCatgName;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Book"),
      ),
      body: Consumer<PostedBookModel>(
        builder: (context, postedBookModel, child) {
          return SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: postedBookModel.bookName,
                      decoration: InputDecoration(
                        hintText: "Book Name",
                        suffixIcon: Icon(FontAwesomeIcons.book),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Book Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.isbnNo,
                      decoration: InputDecoration(
                        hintText: "ISBN Number",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter ISBN Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.authorName,
                      decoration: InputDecoration(
                        hintText: "Author Name",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Author Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.pubName,
                      decoration: InputDecoration(
                        hintText: "Publisher Name",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Publisher Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.mrpPrice,
                      decoration: InputDecoration(
                        hintText: "MRP price",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter MRP Price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.price,
                      decoration: InputDecoration(
                        hintText: "Price",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.bookCatgName,
                      decoration: InputDecoration(
                        hintText: "Book Category Name",
                        suffixIcon: Icon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Book Category Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     Text("Choose Book Image"),
                    //     InkWell(
                    //       onTap: () {
                    //         postedBookModel.chooseBookImage();
                    //       },
                    //       child: Icon(Icons.image),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        await postedBookModel.editBook(
                            book.bookId, scaffoldKey);
                        if (postedBookModel.isEdited) {
                          postedBookModel.bookName.clear();
                          postedBookModel.isbnNo.clear();
                          postedBookModel.authorName.clear();
                          postedBookModel.pubName.clear();
                          postedBookModel.mrpPrice.clear();
                          postedBookModel.price.clear();
                          postedBookModel.bookCatgName.clear();
                          // postedBookModel.bookName.clear();
                          // postedBookModel.bookName.clear();
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'home', (Route<dynamic> route) => false);
                          showFlutterToast("Book Edit Successfully");
                        } else {
                          showFlutterToast(
                              "Somthing went wrong Please try again");
                        }
                      },
                      child: Text("Edit Book"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
