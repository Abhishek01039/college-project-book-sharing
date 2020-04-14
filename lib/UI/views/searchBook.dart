import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    final ThemeData theme = Theme.of(context);

    assert(theme != null);
    return SPHelper.getBool("DarkTheme")
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
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
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
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // BookModel bookModel = Provider.of(context);
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    } else {
      return Consumer<BookModel>(
        builder: (_, bookModel, __) {
          return FutureBuilder(
            future: bookModel.searchOperation(query),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetail(
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
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          );
        },
      );
    }
  }
}
