import 'dart:async';

import 'package:animations/animations.dart';
import 'package:booksharing/UI/views/book_screens/bookDetail.dart';
import 'package:booksharing/UI/views/book_screens/myPostedBookDetail.dart';
import 'package:booksharing/UI/views/book_screens/postedBook.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/UI/widgets/drawer.dart';

import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
// import 'package:booksharing/locator.dart';

// import 'package:booksharing/locator.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/book_screens/searchBook.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hive/hive.dart';

const double _fabDimension = 56.0;

class HomePage extends StatefulWidget {
  static final tag = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box("Student");

  final ContainerTransitionType _transitionType =
      ContainerTransitionType.fadeThrough;
  var isShimmerShown;
  int count = 0;
  var isListShimmerShown;
  int count1 = 0;

  @override
  Widget build(BuildContext context) {
    // show list of books from 7 to 12
    // final BookModel book1 = locator<BookModel>();
    final BookModel book = Provider.of(context);

    // book1.bookApi();
    // book.getHomeListProvider();
    // book.getLatestBookProvider();
    // book1.getBooks();
    // book.getHomeList();
    // book.getLatestBook();
    _firstFutureBuilder(BuildContext context, BookModel bookModel) {
      if (count1 == 0) {
        isListShimmerShown = Container(
          width: double.infinity,
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                            padding: EdgeInsets.symmetric(vertical: 5.0),
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
        Timer(Duration(seconds: 5), () {
          if (bookModel.homeListBook.length == 0) {
            setState(() {
              count1 = 1;
              isListShimmerShown = Container();
            });
          }
        });
      }
      return bookModel.homeListBook != null
          ? bookModel.homeListBook.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: bookModel.homeListBook.length > 6
                      ? 6
                      : bookModel.homeListBook.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (con, int index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        dense: false,
                        // leading: bookImage != null

                        leading:
                            bookModel.homeListBook[index].bookImage.length != 0
                                ? ClipRRect(
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      width: 70,
                                      placeholder:
                                          AssetImage("assets/book_logo.jpg"),
                                      image: NetworkImage(bookModel
                                          .homeListBook[index]
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
                                        image:
                                            AssetImage("assets/book_logo.jpg"),
                                      ),
                                    ),
                                  ),
                        //     : Image.asset("assets/book_logo.jpg"),
                        title: Text(
                          bookModel.homeListBook[index].bookName,
                        ),
                        subtitle: Text("by" +
                            "  " +
                            bookModel.homeListBook[index].authorName),
                        enabled: true,
                        isThreeLine: true,
                        onTap: () {
                          bookModel.homeListBook[index].postedBy !=
                                  box.get("ID")
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (con) => BookDetail(
                                        book: bookModel.homeListBook[index]),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (con) => MyPostedBookDetail(
                                      book: bookModel.homeListBook[index],
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
                  },
                )
              : isListShimmerShown
          : Container();
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
              book.bookApi();
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
          // bookModel.getHomeListProvider();
          // bookModel.callWhenGoBack();
          // bookModel.getLatestBookProvider();

          if (count == 0) {
            isShimmerShown = Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.0,
                        height: 130.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // width: double.infinity,
                            height: 38.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),

                          // Container(
                          //   width: 40.0,
                          //   height: 8.0,
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            );
            Timer(Duration(seconds: 2), () {
              if (bookModel.latestBooks.length == 0) {
                setState(() {
                  count = 1;
                  isShimmerShown =
                      //  Column(
                      //   children: <Widget>[
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 2.5,
                      // ),
                      Center(
                    child: Text(
                      "No posted Book yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                  //   ],
                  // );
                });
              } else {
                isShimmerShown = Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 2.0, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.0,
                            height: 130.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // width: double.infinity,
                                height: 38.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                              ),

                              // Container(
                              //   width: 40.0,
                              //   height: 8.0,
                              //   color: Colors.white,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    itemCount: 6,
                  ),
                );
              }
            });
          }

          return RefreshIndicator(
            onRefresh: bookModel.refreshLocalGallery,
            backgroundColor: Theme.of(context).primaryColor,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    bookModel.latestBooks.length != 0
                        ? Text("Latest Books")
                        : Container(),
                    Container(
                      height: 200,
                      // horizontal list order by posted date
                      child: bookModel.latestBooks.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: bookModel.latestBooks.length > 6
                                  ? 6
                                  : bookModel.latestBooks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    bookModel.latestBooks[index].postedBy !=
                                            box.get("ID")
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (con) => BookDetail(
                                                book: bookModel
                                                    .latestBooks[index],
                                              ),
                                            ),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (con) =>
                                                  MyPostedBookDetail(
                                                book: bookModel
                                                    .latestBooks[index],
                                              ),
                                            ),
                                          );
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            left: 10,
                                            top: 20,
                                            child: Container(
                                              height: 100,
                                              width: 120,
                                              // color: Colors.transparent,
                                              child: ClipRRect(
                                                child: FadeInImage(
                                                  // fit: BoxFit.cover,
                                                  // width: 70,
                                                  placeholder: AssetImage(
                                                      "assets/book_logo.jpg"),
                                                  image: bookModel
                                                              .latestBooks[
                                                                  index]
                                                              .bookImage
                                                              .length !=
                                                          0
                                                      ? NetworkImage(bookModel
                                                          .latestBooks[index]
                                                          .bookImage[0]
                                                          .image
                                                          .toString())
                                                      : AssetImage(
                                                          "assets/book_logo.jpg"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 130,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black54
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 15,
                                            // left: 30,
                                            child: Center(
                                              child: Text(
                                                bookModel.latestBooks[index]
                                                    .bookName,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                          // Text("This is book")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          // : Shimmer.fromColors(
                          //     baseColor: Colors.grey[300],
                          //     highlightColor: Colors.grey[100],
                          //     enabled: true,
                          //     child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       shrinkWrap: true,
                          //       primary: false,
                          //       itemBuilder: (_, __) => Padding(
                          //         padding: const EdgeInsets.only(
                          //             bottom: 2.0, top: 10),
                          //         child: Row(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               width: 150.0,
                          //               height: 130.0,
                          //               color: Colors.white,
                          //             ),
                          //             const Padding(
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: 8.0),
                          //             ),
                          //             Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: <Widget>[
                          //                 Container(
                          //                   // width: double.infinity,
                          //                   height: 38.0,
                          //                   color: Colors.white,
                          //                 ),
                          //                 const Padding(
                          //                   padding: EdgeInsets.symmetric(
                          //                       vertical: 5.0),
                          //                 ),

                          //                 // Container(
                          //                 //   width: 40.0,
                          //                 //   height: 8.0,
                          //                 //   color: Colors.white,
                          //                 // ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       itemCount: 6,
                          //     ),
                          //   )
                          : isShimmerShown,

                      // : Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                    ),
                    // : Column(
                    //     children: <Widget>[
                    //       SizedBox(
                    //         height:
                    //             MediaQuery.of(context).size.height / 2.5,
                    //       ),
                    //       Center(
                    //         child: Text("no posted Book yet"),
                    //       ),
                    //     ],
                    //   ),
                    // : widget,

                    _firstFutureBuilder(context, bookModel),
                    bookModel.homeListBook.length != 0 ||
                            bookModel.latestBooks.length != 0
                        ? Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, 'allBooks');
                              },
                              title: Center(
                                child: Text("All Books"),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      drawer: DrawerMenu(),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: "Post Your Book",
      //   onPressed: () {
      //     Navigator.pushNamed(context, "postedBook");
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: OpenContainer(
        transitionDuration: Duration(seconds: 1),
        transitionType: _transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return PostedBook();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            child: SizedBox(
              height: _fabDimension,
              width: _fabDimension,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
