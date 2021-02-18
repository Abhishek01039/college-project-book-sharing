import 'dart:async';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';

import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class BookModel extends BaseModel with Api {
  Stream<List<Book>> get book => _bookSubject.stream;
  StreamController<List<Book>> _bookSubject = BehaviorSubject<List<Book>>();

  Stream<List<Book>> get filterBook => _filterBookSubject.stream;
  final _filterBookSubject = BehaviorSubject<List<Book>>();

  int selection;
  int choiceChipSelection = 0;
  List<Book> bookList = <Book>[];
  List<Book> latestBooks = <Book>[];
  List<Book> homeListBook = <Book>[];
  bool isSearching = false;

  bookApi() async {
    getBooks().asStream().map((event) {
      return event;
    }).listen((event) {
      _bookSubject.sink.add(event);
    });
  }

  String testing() {
    return "Unit Testing";
  }

  Future<int> checkLength() async {
    int value = await book.length;
    return value;
  }

  //get the list of books regarding the chips is selected by user
  Future<void> filterBookRegardingChips(int index) async {
    bookApi();
    List<Book> filterBooksList = <Book>[];

    await for (var i in book) {
      filterBooksList.clear();
      print(i);
      for (var j in i) {
        if (index == 0) {
          filterBooksList.add(j);
        } else if (index == 1) {
          if (j.price > 0 && j.price <= 150) {
            filterBooksList.add(j);
          }
        } else if (index == 2) {
          if (j.price > 150 && j.price <= 500) {
            filterBooksList.add(j);
          }
        } else if (index == 3) {
          if (j.price > 500) {
            filterBooksList.add(j);
          }
        }
      }

      _filterBookSubject.sink.add(filterBooksList);

      notifyListeners();
    }
  }

  getLatestBookProvider() async {
    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));

      if (i.length < 5) {
        latestBooks = i;
      } else {
        latestBooks = i.sublist(i.length - 5, i.length);
      }

      latestBooks = List.from(latestBooks.reversed);

      notifyListeners();
    }
  }

  getHomeListProvider() async {
    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));

      homeListBook = i.sublist(0, i.length > 4 ? 5 : i.length);

      notifyChange();
    }
  }

  Future<Null> refreshLocalGallery() async {
    bookApi();
    getHomeListProvider();
    getLatestBookProvider();
  }

  callWhenGoBack() {
    bookApi();
    getHomeListProvider();
    getLatestBookProvider();
  }

  BookModel() {
    getHomeListProvider();
    bookApi();
    getLatestBookProvider();
  }

  getBookByCategory(String catg) async {}

  Future<List<Book>> getBookById(int id) async {
    bookList = await getBookByPosted(id);

    return bookList;
  }

  //
  popupmenuSelection(dynamic value) {
    selection = value;
    notifyChange();
  }

  List<Book> searchresult = [];
  Future<List<Book>> searchOperation(String searchText) async {
    searchresult.clear();

    book.forEach((e) {
      for (int i = 0; i < e.length; i++) {
        if (e[i].bookName.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(e[i]);
        }
      }
    });

    return searchresult;
  }

  @override
  void dispose() {
    _bookSubject?.close();
    _filterBookSubject?.close();

    super.dispose();
  }

  changeChoiceChip(bool value, int index) {
    choiceChipSelection = value ? index : -1;
    notifyListeners();
  }
}

class MockBookModel extends Mock with Api implements BookModel {}
