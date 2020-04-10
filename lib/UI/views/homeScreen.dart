import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/widgets/drawer.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:booksharing/core/viewModels/studentLogInModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BookModel bookModel = Provider.of(context);

    bookModel.bookApi();
    _firstStreamBuilder(con, book) {
      return StreamBuilder(
        stream: book,
        builder: (BuildContext con, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
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
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      );
    }

    return Consumer<BookModel>(
      builder: (context, bookmodel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Book Sharing"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _firstStreamBuilder(context, bookmodel.book),
              ],
            ),
          ),
          drawer: DrawerMenu(),
        );
      },
    );
  }
}
