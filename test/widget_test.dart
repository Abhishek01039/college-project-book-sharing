// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
// import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  MockBookModel _mockBookModel;
  setUp(() {
    // Create mock object.
    _mockBookModel = MockBookModel();
  });

  test("Test Book Model", () {
    // Interact with the mock object.
    _mockBookModel.testing();

    // Verify the interaction.
    verify(_mockBookModel.testing());

    // expect(_mockBookModel.testing(), "Unit Testing");
    when(_mockBookModel.testing()).thenReturn("Unit Testing");
    expect(_mockBookModel.testing(), "Unit Testing");
  });

  test("Get the Book Model", () {
    // Interact with the mock object.
    _mockBookModel.bookApi();

    // Verify the interaction.
    verify(_mockBookModel.bookApi());

    // expect(_mockBookModel.testing(), "Unit Testing");
    when(_mockBookModel.bookApi()).thenReturn([]);
    expect(_mockBookModel.bookApi(), []);
  });

  test("Get the Book Model By ID", () {
    // Interact with the mock object.
    _mockBookModel.getBookById(12);
    // List<Book> book = [
    //   // Book(
    //   //   bookId: 20,
    //   //   bookName: "transandence",
    //   //   isbnNo: "57837474",
    //   //   authorName: "v m verma",
    //   //   pubName: "cengage publisher",
    //   //   originalPrice: 500,
    //   //   price: 50,
    //   //   bookCatgName: "jabxbcb",
    //   //   postedBy: 4,
    //   //   postedDate: "2020-04-20T14:15:29.594657+05:30",
    //   //   bookImage: [],
    //   // )
    // ];
    // Verify the interaction.
    // verifyNever(_mockBookModel.getBookById(20));
    verifyNever(_mockBookModel.getBookById(20));

    // when(_mockBookModel.getBookById(20)).thenAnswer((_) async {
    //   print(book);
    //   return book;
    // });
    // // await function();
    // expect(_mockBookModel.getBookById(20), List<Book>());
    // when(http.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer(
    //   (_) async => http.Response(
    //     '{"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}',
    //     200,
    //   ),
    // );

    expect(_mockBookModel.getBookById(2), null);
  });
  test("Verification the order of Book Model", () {
    _mockBookModel.getHomeList();
    _mockBookModel.bookApi();
    _mockBookModel.getLatestBook();
    verifyInOrder(
      [
        _mockBookModel.getHomeList(),
        _mockBookModel.bookApi(),
        _mockBookModel.getLatestBook()
      ],
    );
  });
}
