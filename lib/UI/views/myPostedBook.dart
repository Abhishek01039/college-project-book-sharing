import 'dart:developer';

import 'package:booksharing/UI/views/bookDelete.dart';

import 'package:booksharing/UI/views/bookEdit.dart';
import 'package:booksharing/UI/views/myPostedBookDetail.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

class MyPostedBook extends StatelessWidget {
  static final tag = "myPostedBook";
  @override
  Widget build(BuildContext context) {
    // show alert dialog box to ensure that you have to delete the book
    Future<void> _deleteBook(int bookId) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Want to delete Book?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, 'bookdelete');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDelete(
                        bookId: bookId,
                      ),
                    ),
                  );
                },
                child: Text("Yes"),
              )
            ],
          );
        },
      );
    }

    // Widget _selectPopup() => PopupMenuButton<int>(
    //     itemBuilder: (context) => [
    //           PopupMenuItem(
    //             value: 1,
    //             child: Text("Show"),
    //           ),
    //           PopupMenuItem(
    //             value: 2,
    //             child: Text("Delete"),
    //           ),
    //         ],
    //     initialValue: 2,
    //     onCanceled: () {
    //       print("You have canceled the menu.");
    //     },
    //     onSelected: (value) {}
    //     // print("value:$value");

    //     );
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posted Book"),
      ),
      body: Consumer<BookModel>(
        builder: (context, bookModel, child) {
          final box = Hive.box("Student");
          // fetch all book purchased by student who is logged in App.
          return Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder(
              future: bookModel.getBookById(box.get("ID")),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? snapshot.data.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (con, int index) {
                              return Card(
                                elevation: 3,
                                child: ListTile(
                                  // leading: bookImage != null

                                  leading:
                                      snapshot.data[index].bookImage.length != 0
                                          ? ClipRRect(
                                              child: FadeInImage(
                                                fit: BoxFit.cover,
                                                width: 70,
                                                placeholder: AssetImage(
                                                    "assets/book_logo.jpg"),
                                                image: NetworkImage(
                                                    "https://booksharingappdjango.herokuapp.com" +
                                                        snapshot.data[index]
                                                            .bookImage[0].image
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
                                                  image: AssetImage(
                                                      "assets/book_logo.jpg"),
                                                ),
                                              ),
                                            ),
                                  //     : Image.asset("assets/book_logo.jpg"),
                                  title: Text(snapshot.data[index].bookName),
                                  subtitle: Text("by" +
                                      "  " +
                                      snapshot.data[index].authorName),
                                  // enabled: true,
                                  dense: false,
                                  isThreeLine: true,
                                  // isThreeLine: true,
                                  // trailing: Flexible(
                                  //   child: Row(
                                  //     children: <Widget>[
                                  //       Icon(Icons.edit),
                                  //       SizedBox(
                                  //         width: 10,
                                  //       ),
                                  //       Icon(
                                  //         Icons.delete,
                                  //         color: Colors.red,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.edit,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Edit"),
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
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Delete"),
                                          ],
                                        ),
                                      ),
                                    ],
                                    child: Icon(Icons.more_vert),
                                    onSelected: (result) {
                                      // print("sfasfsf");

                                      bookModel.popupmenuSelection(result);
                                      if (result == 1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookEdit(
                                              book: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      }
                                      if (result == 2) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookDelete(
                                              bookId:
                                                  snapshot.data[index].bookId,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    onCanceled: () {
                                      log("canceled");
                                    },
                                  ),
                                  // _selectPopup();

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (con) => MyPostedBookDetail(
                                            book: snapshot.data[index]),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text("No posted yet"),
                          )
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          enabled: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 40.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: 6,
                          ),
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
