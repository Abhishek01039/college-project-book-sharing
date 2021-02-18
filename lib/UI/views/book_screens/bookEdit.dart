import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/book_provider/bookEditModel.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookEdit extends StatelessWidget {
  BookEdit({Key key, this.book})
      : assert(book != null),
        super(key: key);

  static final tag = RoutePaths.PostedBook;
  final Book book;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    BookModel _bookModel = Provider.of<BookModel>(context);
    PostedBookEditModel postedBookEditModel = Provider.of(context);
    if (postedBookEditModel.autoValidate == false) {
      postedBookEditModel.bookName.text = book.bookName;
      postedBookEditModel.isbnNo.text = book.isbnNo;
      postedBookEditModel.authorName.text = book.authorName;
      postedBookEditModel.pubName.text = book.pubName;
      postedBookEditModel.mrpPrice.text = book.originalPrice.toString();
      postedBookEditModel.price.text = book.price.toString();
      postedBookEditModel.edition.text = book.edition ?? "";
      postedBookEditModel.bookCatgName.text = book.bookCatgName;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Book"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: postedBookEditModel.formKey,
          autovalidateMode: postedBookEditModel.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.bookName,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  controller: postedBookEditModel.edition,
                  decoration: const InputDecoration(
                    hintText: "edition (optional)",
                    suffixIcon: Icon(Icons.category),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: postedBookEditModel.bookCatgName,
                  decoration: const InputDecoration(
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
                const SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  onPressed: () async {
                    await postedBookEditModel
                        .editBookProvider(book.bookId, scaffoldKey, context)
                        .then((value) {
                      if (value) {
                        _bookModel.bookApi();
                        _bookModel.getHomeListProvider();
                        _bookModel.getLatestBookProvider();
                      }
                    });
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
