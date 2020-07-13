import 'dart:async';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';

// import 'package:booksharing/locator.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class BookModel extends BaseModel with Api {
  Stream<List<Book>> get book => _bookSubject.stream;
  StreamController<List<Book>> _bookSubject = BehaviorSubject<List<Book>>();

  Stream<List<Book>> get filterBook => _filterBookSubject.stream;
  final _filterBookSubject = BehaviorSubject<List<Book>>();

  // Api = locator<Api>();
  int selection;
  int choiceChipSelection = 0;
  List<Book> bookList = <Book>[];
  List<Book> latestBooks = <Book>[];
  List<Book> homeListBook = <Book>[];
  bool isSearching = false;

  // final TextEditingController controller = TextEditingController();

  // get all books detail and sink it into stream
  bookApi() async {
    // final channel = IOWebSocketChannel.connect(
    //   // Uri.parse(
    // 'ws://$YOUR_SERVER_IP:$YOUR_SERVER_PORT',
    //   // ),
    //   "ws://echo.websocket.org"
    // );
    // final channel = IOWebSocketChannel.connect('ws://192.168.43.182:8000/ws');
    getBooks().asStream().map((event) {
      // print(event);
      return event;
    }).listen((event) {
      // print(event);
      _bookSubject.sink.add(event);
      // channel.sink.add("hello");
    });
    // _bookSubject.sink.add(await getBooks());
    // notifyListeners();
    // await for (var i in channel.stream) {
    //   print(i);
    // }
  }

  // Testing purpose
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
    // Future.delayed(Duration(seconds: 5));
    // Timer(Duration(seconds: 10), () async {
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
      // i.map((e) {
      //   if (index == 0) {
      //     filterBooksList.add(e);
      //   } else if (index == 1) {
      //     if (e.price > 0 && e.price <= 150) {
      //       filterBooksList.add(e);
      //     }
      //   } else if (index == 2) {
      //     if (e.price > 150 && e.price <= 500) {
      //       filterBooksList.add(e);
      //     }
      //   } else if (index == 3) {
      //     if (e.price > 500) {
      //       filterBooksList.add(e);
      //     }
      //   }
      // });

      // latestBooks = List.from(latestBooks.reversed);
      _filterBookSubject.sink.add(filterBooksList);

      notifyListeners();
    }
    // });
  }

  // get latest books according to posted date
  getLatestBookProvider() async {
    // latestBooks = await getLatestBook();
    // var total = await _bookSubject.stream.length;
    // print(total);
    // if (await book.length != 0) {
    // checkLength().then((value) async {
    //   if (value != 0) {
    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));
      // i.forEach((e) {
      //   log(e.postedDate);
      // });
      if (i.length < 5) {
        latestBooks = i;
      } else {
        latestBooks = i.sublist(i.length - 5, i.length);
      }

      latestBooks = List.from(latestBooks.reversed);

      // print(latestBooks);
      notifyListeners();
      // }
    }
    // });

    // notifyChange();
    // print("hello latest list");
  }

  // get books details from 7-12 books
  getHomeListProvider() async {
    // homeListBook = await getHomeList();
    // if (await book.length != 0) {
    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));
      // i.forEach((e) {
      //   log(e.postedDate);
      // });

      homeListBook = i.sublist(0, i.length > 4 ? 5 : i.length);
      // print(homeListBook);
      notifyChange();
    }
    // }
    // notifyChange();

    // return homeListBook;
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
    // bookApi();
    getHomeListProvider();
    bookApi();
    getLatestBookProvider();
  }

  getBookByCategory(String catg) async {}

  // get books by ID
  Future<List<Book>> getBookById(int id) async {
    bookList = await getBookByPosted(id);
    // notifnotifyChange();
    return bookList;
  }

  //
  popupmenuSelection(dynamic value) {
    selection = value;
    notifyChange();
  }

  //  it create list from stream and show it into search delegate
  List<Book> searchresult = [];
  Future<List<Book>> searchOperation(String searchText) async {
    searchresult.clear();
    // List<Book> books = [];

    // for (int i=0;i<book.length;i++) {
    //   books = book;
    // }
    // if(book.isEmpty){

    // }
    // var streamLength = await _bookSubject.stream.length;
    // print(streamLength);
    // if (streamLength != 0) {
    // if (await book.length != 0) {
    book.forEach((e) {
      for (int i = 0; i < e.length; i++) {
        if (e[i].bookName.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(e[i]);
        }
      }
    });
    // }
    // }
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
    _filterBookSubject?.close();
    // _bookImageSubject?.close();
    super.dispose();
  }

  changeChoiceChip(bool value, int index) {
    // if(value){
    choiceChipSelection = value ? index : -1;
    notifyListeners();
    // }
  }
}

class MockBookModel extends Mock with Api implements BookModel {}
