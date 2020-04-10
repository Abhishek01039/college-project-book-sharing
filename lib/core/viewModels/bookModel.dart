import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';
import 'package:rxdart/rxdart.dart';

class BookModel extends BaseModel {
  Stream<List<Book>> get book => _bookSubject.stream;
  final _bookSubject = BehaviorSubject<List<Book>>();
  // Stream<List<BookImage>> get bookImage => _bookImageSubject.stream;
  // final _bookImageSubject = BehaviorSubject<List<BookImage>>();
  // BookImage bookImage=locator<BookImage>();
  Api _api = locator<Api>();
  int selection;
  List<Book> bookList = new List();
  bookApi() async {
    _bookSubject.sink.add(await _api.getBooks());
    notifyListeners();
  }

  getBookByCategory(String catg) async {}

  Future<List<Book>> getBookById(int id) async {
    bookList = await _api.getBookByPosted(id);
    return bookList;
  }

  popupmenuSelection(dynamic value){
    selection=value;
    notifyListeners();
  }

  @override
  void dispose() {
    _bookSubject?.close();
    // _bookImageSubject?.close();
    super.dispose();
  }
}
