import 'dart:developer';

import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/views/bookEdit.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPostedBook extends StatelessWidget {
  static final tag = "myPostedBook";
  @override
  Widget build(BuildContext context) {
    Widget _selectPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Show"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Delete"),
              ),
            ],
        initialValue: 2,
        onCanceled: () {
          print("You have canceled the menu.");
        },
        onSelected: (value) {}
        // print("value:$value");

        );
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Shearing"),
      ),
      body: Consumer<BookModel>(
        builder: (context, bookModel, child) {
          return FutureBuilder(
            future: bookModel.getBookById(SPHelper.getInt("ID")),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  print("done");

                  break;
                case ConnectionState.none:
                  print("none");
                  break;
                case ConnectionState.waiting:
                  print("Waiting");
                  break;
                case ConnectionState.active:
                  print("active");
                  break;
              }
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (con, int index) {
                        return ListTile(
                          // leading: bookImage != null

                          leading: snapshot.data[index].bookImage.length != 0
                              ? ClipRRect(
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    width: 70,
                                    placeholder:
                                        AssetImage("assets/book_logo.jpg"),
                                    image: NetworkImage(
                                        "http://192.168.43.182:8000" +
                                            snapshot
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
                                      image: AssetImage("assets/book_logo.jpg"),
                                    ),
                                  ),
                                ),
                          //     : Image.asset("assets/book_logo.jpg"),
                          title: Text(snapshot.data[index].bookName),
                          subtitle: Text(
                              "by" + "  " + snapshot.data[index].authorName),
                          enabled: true,
                          isThreeLine: true,
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
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text("Delete"),
                              ),
                            ],
                            child: Icon(Icons.more_vert),
                            onSelected: (result) {
                              print("sfasfsf");

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
                                builder: (con) =>
                                    BookDetail(book: snapshot.data[index]),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          );
        },
      ),
    );
  }
}
