import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/bookEditModel.dart';

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
    PostedBookEditModel postedBookEditModel = Provider.of(context);
    postedBookEditModel.bookName.text = book.bookName;
    postedBookEditModel.isbnNo.text = book.isbnNo;
    postedBookEditModel.authorName.text = book.authorName;
    postedBookEditModel.pubName.text = book.pubName;
    postedBookEditModel.mrpPrice.text = book.originalPrice.toString();
    postedBookEditModel.price.text = book.price.toString();
    postedBookEditModel.bookCatgName.text = book.bookCatgName;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Book"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.bookName,
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
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.isbnNo,
                  decoration: InputDecoration(
                    hintText: "ISBN Number",
                    suffixIcon: Icon(FontAwesomeIcons.barcode),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter ISBN Number';
                    } else if (value.length < 13) {
                      return "Enter Proper ISBN Number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.authorName,
                  decoration: InputDecoration(
                    hintText: "Author Name",
                    suffixIcon: Icon(FontAwesomeIcons.userEdit),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Author Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.pubName,
                  decoration: InputDecoration(
                    hintText: "Publisher Name",
                    suffixIcon: Icon(FontAwesomeIcons.book),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Publisher Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.mrpPrice,
                  decoration: InputDecoration(
                    hintText: "MRP price",
                    suffixIcon: Icon(FontAwesomeIcons.rupeeSign),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter MRP Price';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.price,
                  decoration: InputDecoration(
                    hintText: "Price",
                    suffixIcon: Icon(FontAwesomeIcons.rupeeSign),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Price';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.bookCatgName,
                  decoration: InputDecoration(
                    hintText: "Book Category Name",
                    suffixIcon: Icon(Icons.category),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Book Category Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     Text("Choose Book Image"),
                //     InkWell(
                //       onTap: () {
                //         postedBookEditModel.chooseBookImage();
                //       },
                //       child: Icon(Icons.image),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  onPressed: () async {
                    await postedBookEditModel.editBook(
                        book.bookId, scaffoldKey);
                    if (postedBookEditModel.isEdited) {
                      postedBookEditModel.bookName.clear();
                      postedBookEditModel.isbnNo.clear();
                      postedBookEditModel.authorName.clear();
                      postedBookEditModel.pubName.clear();
                      postedBookEditModel.mrpPrice.clear();
                      postedBookEditModel.price.clear();
                      postedBookEditModel.bookCatgName.clear();
                      // postedBookEditModel.bookName.clear();
                      // postedBookEditModel.bookName.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'home', (Route<dynamic> route) => false);
                      showFlutterToast("Book Edit Successfully");
                    } else if (postedBookEditModel.isEdited == null) {
                    } else {
                      showFlutterToast("Somthing went wrong Please try again");
                    }
                  },
                  child: Text("Edit Book"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
