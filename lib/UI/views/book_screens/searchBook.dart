import 'package:booksharing/UI/views/book_screens/bookDetail.dart';
import 'package:booksharing/UI/views/book_screens/myPostedBookDetail.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final darkTheme = Hive.box("DarkTheme");
    assert(theme != null);
    return darkTheme.get("darkTheme", defaultValue: false)
        ? theme.copyWith(
            primaryColor: Colors.black38,
            primaryIconTheme:
                theme.primaryIconTheme.copyWith(color: Colors.grey),
            primaryColorBrightness: Brightness.dark,
            primaryTextTheme: theme.textTheme,
          )
        : super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // clear icon in tralling
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // back arrow icon at leading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // BookModel bookModel = Provider.of(context);

    if (query.isNotEmpty)

      // return list of books which student wants to search
      return Consumer<BookModel>(
        builder: (_, bookModel, __) {
          return FutureBuilder(
              future: bookModel.searchOperation(query),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return snapshot.hasData
                    ? snapshot.data.length != 0
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  final box = Hive.box("Student");
                                  snapshot.data[index].postedBy != box.get("ID")
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookDetail(
                                              book: snapshot.data[index],
                                            ),
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
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].bookName.toString(),
                                  ),
                                ),
                              );
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text(
                                  "No results found for '$query'",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Text(
                              "No results found for '$query'",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      );
              });
        },
      );
    return Container();
  }
}
