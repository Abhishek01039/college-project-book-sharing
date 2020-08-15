import 'package:booksharing/UI/views/book_screens/bookDetail.dart';
import 'package:booksharing/UI/views/book_screens/myPostedBookDetail.dart';

import 'package:booksharing/core/constant/app_constant.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';

import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FilterBook extends StatelessWidget {
  static final tag = RoutePaths.FilterBook;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final box = Hive.box("Student");
    // final BookModel bookModel = Provider.of(context);
    // bookModel.bookApi();
    // all books show in list
    _firstStreamBuilder(filterBook) {
      return StreamBuilder(
        stream: filterBook,
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return snapshot.hasData
              ? snapshot.data.length == 0
                  ? Center(
                      child: Text("No Books found"),
                    )
                  : Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown: true,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ListView.builder(
                          // shrinkWrap: true,
                          // primary: false,
                          controller: _scrollController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (con, int index) {
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                dense: false,
                                // leading: bookImage != null

                                leading:
                                    snapshot.data[index].bookImage.length != 0
                                        ? ClipRRect(
                                            child: FadeInImage(
                                              fit: BoxFit.cover,
                                              width: 70,
                                              placeholder: AssetImage(
                                                  "assets/book_logo.jpg"),
                                              image: NetworkImage(snapshot
                                                  .data[index]
                                                  .bookImage[0]
                                                  .image
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
                                                      "assets/book_logo.jpg")),
                                            ),
                                          ),
                                //     : Image.asset("assets/book_logo.jpg"),
                                title: Text(snapshot.data[index].bookName),
                                subtitle: Text("by" +
                                    "  " +
                                    snapshot.data[index].authorName),
                                enabled: true,
                                isThreeLine: true,
                                onTap: () {
                                  snapshot.data[index].postedBy != box.get("ID")
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (con) => BookDetail(
                                                book: snapshot.data[index]),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (con) =>
                                                MyPostedBookDetail(
                                              book: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
              : Container(
                  width: double.infinity,
                  height: 500,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: true,
                    child: ListView.builder(
                      shrinkWrap: true,
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
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
      );
    }

    Widget appBarTitle = Text(
      "Filter Books",
      // style: TextStyle(color: Colors.white),
    );

    // final globalKey = GlobalKey<ScaffoldState>();
    Widget buildAllBar(BuildContext context) {
      return AppBar(
        title: appBarTitle,
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // search delegate
        //       showSearch(context: context, delegate: Search());
        //     },
        //   ),
        // ],
      );
    }

    return Scaffold(
      // key: globalKey,
      appBar: buildAllBar(context),
      body: Consumer<BookModel>(
        builder: (context, bookModel, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
            child: _firstStreamBuilder(bookModel.filterBook),
          );
        },
      ),
    );
  }
}
