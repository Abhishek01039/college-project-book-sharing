import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPostedBook extends StatelessWidget {
  static final tag = "myPostedBook";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Shearing"),
      ),
      body: Consumer<BookModel>(
        builder: (context, bookModel, child) {
          return Container();
        },
      ),
    );
  }
}
