import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/views/searchBook.dart';

import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AllBooks extends StatelessWidget {
  static final tag = "allBooks";
  @override
  Widget build(BuildContext context) {
    final BookModel bookModel = Provider.of(context);
    bookModel.bookApi();
    // all books show in list
    _firstStreamBuilder(book) {
      return StreamBuilder(
        stream: book,
        builder: (_, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount:
                      snapshot.data.length > 6 ? 6 : snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (con, int index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        dense: false,
                        // leading: bookImage != null

                        leading: snapshot.data[index].bookImage.length != 0
                            ? ClipRRect(
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  width: 70,
                                  placeholder:
                                      AssetImage("assets/book_logo.jpg"),
                                  image: NetworkImage(snapshot
                                      .data[index].bookImage[0].image
                                      .toString()),
                                ),
                              )
                            // : Container(width: 70,height: 40,),
                            // : ClipRRect(

                            //     child: Image.asset(
                            //       "assets/book_logo.jpg",
                            //       height: 40,
                            //       width: 70,
                            //     ),
                            //   )
                            : Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage("assets/book_logo.jpg")),
                                ),
                              ),
                        //     : Image.asset("assets/book_logo.jpg"),
                        title: Text(snapshot.data[index].bookName),
                        subtitle:
                            Text("by" + "  " + snapshot.data[index].authorName),
                        enabled: true,
                        isThreeLine: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (con) =>
                                  BookDetail(book: snapshot.data[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      );
    }

    Widget appBarTitle = Text(
      "Book Shearing",
      // style: TextStyle(color: Colors.white),
    );

    // final globalKey = GlobalKey<ScaffoldState>();
    Widget buildAllBar(BuildContext context) {
      return AppBar(
        title: appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // search delegate
              showSearch(context: context, delegate: Search());
            },
          ),
        ],
      );
    }

    return Scaffold(
      // key: globalKey,
      appBar: buildAllBar(context),
      body: Consumer<BookModel>(
        builder: (context, bookModel, _) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _firstStreamBuilder(bookModel.book),
              ],
            ),
          );
        },
      ),
    );
  }
}
