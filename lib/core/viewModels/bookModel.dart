import 'dart:developer';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class BookModel extends BaseModel {
  Stream<List<Book>> get book => _bookSubject.stream;
  final _bookSubject = BehaviorSubject<List<Book>>();
  // Stream<List<BookImage>> get bookImage => _bookImageSubject.stream;
  // final _bookImageSubject = BehaviorSubject<List<BookImage>>();
  // BookImage bookImage=locator<BookImage>();
  Api _api = locator<Api>();
  int selection;
  List<Book> bookList = new List();
  bool isSearching = false;
  final TextEditingController controller = TextEditingController();
  bookApi() async {
    _bookSubject.sink.add(await _api.getBooks());
    notifyListeners();
  }

  getBookByCategory(String catg) async {}

  Future<List<Book>> getBookById(int id) async {
    bookList = await _api.getBookByPosted(id);
    // notifyListeners();
    return bookList;
  }

  popupmenuSelection(dynamic value) {
    selection = value;
    notifyListeners();
  }

  void handleSearchStart() {
    isSearching = true;
    notifyListeners();
  }

  List<Book> searchresult = new List();
  void handleSearchEnd() {
    isSearching = false;
    controller.clear();
    notifyListeners();
  }

  Future<List<Book>> searchOperation(String searchText) async {
    searchresult.clear();
    // List<Book> books = new List();

    // for (int i=0;i<book.length;i++) {
    //   books = book;
    // }
    book.forEach((e){
      for(int i=0;i<e.length;i++){
        if(e[i].bookName.contains(searchText)){
          searchresult.add(e[i]);
        }
      }
    });
    // for (var i in books) {
    //   print(i);
    // }
    // for (int j = 0; j < books.length; j++) {
    //   String data = books[j].bookName;
    //   if (data.toLowerCase().contains(searchText.toLowerCase())) {
    //     searchresult.add(data);
    //   }
    // }
    return searchresult;
  }

  @override
  void dispose() {
    _bookSubject?.close();
    // _bookImageSubject?.close();
    super.dispose();
  }
}
