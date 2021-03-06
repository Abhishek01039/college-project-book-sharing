import 'package:booksharing/core/constant/app_constant.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:booksharing/core/viewModels/book_provider/postedBookModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostedBook extends StatelessWidget {
  static final tag = RoutePaths.PostedBook;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    BookModel bookModel = Provider.of<BookModel>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Post Book"),
      ),
      body: Consumer<PostedBookModel>(
        builder: (context, postedBookModel, child) {
          return SingleChildScrollView(
            child: PostedBookForm(
              postedBookModel: postedBookModel,
              bookModel: bookModel,
              scaffoldKey: scaffoldKey,
            ),
          );
        },
      ),
    );
  }
}

class PostedBookForm extends StatelessWidget {
  final PostedBookModel postedBookModel;
  final BookModel bookModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const PostedBookForm({
    Key key,
    this.postedBookModel,
    this.bookModel,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: postedBookModel.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      key: postedBookModel.formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: postedBookModel.bookName,
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
              // keyboardAppearance: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: postedBookModel.isbnNo,
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
              controller: postedBookModel.authorName,
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
              controller: postedBookModel.pubName,
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
              controller: postedBookModel.mrpPrice,
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
              controller: postedBookModel.price,
              decoration: const InputDecoration(
                hintText: "Selling Price",
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
              controller: postedBookModel.edition,
              decoration: const InputDecoration(
                hintText: "Edition (Optional)",
                suffixIcon: Icon(FontAwesomeIcons.bookReader),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: postedBookModel.bookCatgName,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Choose Book Image"),
                InkWell(
                  onTap: () {
                    postedBookModel.chooseBookImage();
                  },
                  child: Icon(Icons.image),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            RaisedButton(
              onPressed: () async {
                await postedBookModel
                    .registeredBookProvider(context, scaffoldKey)
                    .then((value) {
                  if (value) {
                    bookModel.bookApi();
                    bookModel.getHomeListProvider();
                    bookModel.getLatestBookProvider();
                  }
                });
              },
              child: Text("Post Book"),
            )
          ],
        ),
      ),
    );
  }
}
