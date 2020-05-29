import 'dart:async';

import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';
// import 'package:booksharing/locator.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookModel extends BaseModel with Api {
  Stream<List<Book>> get book => _bookSubject.stream;
  StreamController<List<Book>> _bookSubject = BehaviorSubject<List<Book>>();

  // Api = locator<Api>();
  int selection;
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
    final channel = IOWebSocketChannel.connect('ws://192.168.43.182:8000/ws');
    getBooks().asStream().map((event) {
      return event;
    }).listen((event) {
      // _bookSubject.sink.add(event);
      channel.sink.add("hello");
    });
    // _bookSubject.sink.add(await getBooks());
    // notifnotifyChange();
    await for (var i in channel.stream) {
      print(i);
    }
  }

  // Testing purpose
  String testing() {
    return "Unit Testing";
  }

  // get latest books according to posted date
  getLatestBookProvider() async {
    // latestBooks = await getLatestBook();

    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));
      // i.forEach((e) {
      //   log(e.postedDate);
      // });

      latestBooks = i.sublist(i.length - 5, i.length);
      latestBooks = List.from(latestBooks.reversed);

      print(latestBooks);
      notifyListeners();
    }

    // notifyChange();
    // print("hello latest list");
  }

  // get books details from 7-12 books
  getHomeListProvider() async {
    // homeListBook = await getHomeList();

    await for (var i in book) {
      i.sort((a, b) => a.postedDate.compareTo(b.postedDate));
      // i.forEach((e) {
      //   log(e.postedDate);
      // });

      homeListBook = i.sublist(0, i.length > 4 ? 5 : i.length);
      // print(homeListBook);
      notifyListeners();
    }
    // notifyChange();

    // return homeListBook;
  }

  Future<Null> refreshLocalGallery() async {
    getHomeListProvider();
    getLatestBookProvider();
    bookApi();
  }

  callWhenGoBack() {
    getHomeListProvider();
    bookApi();
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
    book.forEach((e) {
      for (int i = 0; i < e.length; i++) {
        if (e[i].bookName.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(e[i]);
        }
      }
    });
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
    // _bookImageSubject?.close();
    super.dispose();
  }
}

class MockBookModel extends Mock implements BookModel {}
