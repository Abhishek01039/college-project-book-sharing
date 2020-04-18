import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/widgets/drawer.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/searchBook.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/locator.dart';

class HomePage extends StatefulWidget {
  static final tag = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Api _api = locator<Api>();
    // BookModel bookModel = Provider.of(context);
    // bookModel.bookApi();

    // log("Print Home Screen");
    // show list of books from 7 to 12
    _firstFutureBuilder(BuildContext context, BookModel bookModel) {
      return FutureBuilder(
        future: _api.getHomeList(),
        builder: (context, AsyncSnapshot snapshot) {
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
                                    image: AssetImage("assets/book_logo.jpg"),
                                  ),
                                ),
                              ),
                        //     : Image.asset("assets/book_logo.jpg"),
                        title: Text(
                          snapshot.data[index].bookName,
                        ),
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
                    Text("Latest Books"),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetail(
                                          book: bookModel.latestBooks[index],
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
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    _firstFutureBuilder(context, bookModel),
                    Card(
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "postedBook");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
