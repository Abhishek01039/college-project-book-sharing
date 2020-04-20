import 'dart:async';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:rxdart/rxdart.dart';

class BookModel extends BaseModel {
  Stream<List<Book>> get book => _bookSubject.stream;
  StreamController<List<Book>> _bookSubject = BehaviorSubject<List<Book>>();

  Api _api = locator<Api>();
  int selection;
  List<Book> bookList = new List();
  List<Book> latestBooks = new List();
  List<Book> homeListBook = new List();
  bool isSearching = false;
  // final TextEditingController controller = TextEditingController();

  // get all books detail and sink it into stream
  bookApi() async {
    _api.getBooks().asStream().map((event) {
      return event;
    }).listen((event) {
      _bookSubject.sink.add(event);
    });
    // _bookSubject.sink.add(await _api.getBooks());
    // notifyListeners();
    // print(_bookSubject.);
  }

  // get latest books according to posted date
  getLatestBook() async {
    latestBooks = await _api.getLatestBook();
    // notifyListeners();
    // print("hello latest list");
    notifyListeners();
  }

  // get books details from 7-12 books
  getHomeList() async {
    homeListBook = await _api.getHomeList();
    notifyListeners();
    // return homeListBook;
  }

  Future<Null> refreshLocalGallery() async {
    getHomeList();
    getLatestBook();
  }

  BookModel() {
    // bookApi();
    getHomeList();
    bookApi();
    getLatestBook();
  }

  getBookByCategory(String catg) async {}

  // get books by ID
  Future<List<Book>> getBookById(int id) async {
    bookList = await _api.getBookByPosted(id);
    // notifyListeners();
    return bookList;
  }

  //
  popupmenuSelection(dynamic value) {
    selection = value;
    notifyListeners();
  }

  //  it create list from stream and show it into search delegate
  List<Book> searchresult = new List();
  Future<List<Book>> searchOperation(String searchText) async {
    searchresult.clear();
    // List<Book> books = new List();

    // for (int i=0;i<book.length;i++) {
    //   books = book;
    // }
    book.forEach((e) {
      for (int i = 0; i < e.length; i++) {
        if (e[i].bookName.toLowerCase().contains(searchText.toLowerCase())) {
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
