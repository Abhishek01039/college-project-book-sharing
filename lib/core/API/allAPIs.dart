import 'dart:convert';
import 'dart:developer';

import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/locator.dart';

import 'package:booksharing/core/models/book.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Api {
  String api = "https://booksharingappdjango.herokuapp.com/booksharing/";
  basicAuth() {
    String username = 'abhishek';
    String password = 'ABHI01039';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return basicAuth;
  }

  Future<List<Book>> getBooks() async {
    List<Book> book = new List();
    // List<BookImage> image = new List();
    var response =
        await http.get(api + 'book/', headers: {'authorization': basicAuth()});

    var parsed = jsonDecode(response.body);
    // print(parsed);
    // return Book
    for (var i in parsed) {
      book.add(Book.fromJson(i));

      // for (var j in i['Book_Image']) {
      //   // image.add(
      //   //   BookImage.fromJson(j),
      //   // );

      // }
    }
    // await getBookImage();
    // for (var i in )
    // print(image[0].image);
    // print(book);
    return book;
  }

  getBooksById(int id) async {
    Book book = locator<Book>();
    // Student student = locator<Student>();
    var response = await http
        .get(api + 'book/$id', headers: {'authorization': basicAuth()});

    var parsed = jsonDecode(response.body);
    // print(parsed);
    // return Book
    for (var i in parsed) {
      book = Book.fromJson(i);
    }
    // student = getStudentById(book.postedBy);
    // await getBookImage();
    // for (var i in )
    return book;
  }

  Future<Student> getStudentById(int id) async {
    Student student = locator<Student>();

    http.Response response = await http
        .get(api + 'student/$id', headers: {'authorization': basicAuth()});
    // print(response.body);
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      student = Student.fromJson(parsed);
      return student;
      // return parsed;
    } else if (response.statusCode == 400) {
      log("User doesn't exist");
    }
    return null;
  }

  getBookImage(int id) async {
    List<BookImage> image = List<BookImage>();
    http.Response response = await http
        .get(api + 'imagebyid/$id', headers: {'authorization': basicAuth()});
    // print(response.body);
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      for (var i in parsed) {
        image.add(BookImage.fromJson(i));
      }
      return image;
      // return parsed;
    } else if (response.statusCode == 400) {
      log("Book Image is not exist");
    }
    return null;
  }

  Future<Student> logIn(String enrollment, String pass) async {
    Student student = locator<Student>();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // SPHelper.setPref(sharedPreferences);
    // SPHelper.enrollmentNo=;
    http.Response response = await http.post(api + 'login/',
        body: {'enrollmentNo': enrollment, "password": pass},
        headers: {'authorization': basicAuth()});
    // print(response.body);
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      for (var i in parsed) {
        student = Student.fromJson(i);
      }
      final box = Hive.box("Student");

      box.put("ID", student.id);
      box.put("enrollmentNo", student.enrollmentNo);
      box.put("studentName", student.firstName);
      box.put("studentPhoto", "/media/" + student.photo);

      return student;
      // return parsed;
    }
    return null;
  }

  getPurchasedBook(String studId) async {
    http.Response response = await http.post(api + 'student/',
        body: {'studentId': studId}, headers: {'authorization': basicAuth()});
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return parsed;
    }
    return null;
  }

  Future<String> registerStudent(
    String enrollmentNo,
    String firstName,
    String lastName,
    String email,
    String age,
    String password,
    String collegeName,
    String collegeYear,
    String course,
    String address,
    String number,
    String base64Image,
    String extn,
  ) async {
    Student student = locator<Student>();
    http.Response response = await http.post(api + 'student/', body: {
      "enrollmentNo": enrollmentNo,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "age": age,
      "password": password,
      "collegeName": collegeName,
      "collegeYear": collegeYear,
      "address": address,
      "course": course ?? "",
      "contactNo": number,
      "photo": base64Image ?? "",
      "extansion": extn
    }, headers: {
      'authorization': basicAuth(),
    });
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // return parsed;
      student = Student.fromJson(parsed);
      final box = Hive.box("Student");

      box.put("ID", student.id);
      box.put("enrollmentNo", student.enrollmentNo);
      box.put("studentName", student.firstName);
      box.put("studentPhoto", student.photo);

      return "Success";
    }
    print(parsed);
    if (parsed == "Student already Exist") {
      return "Student already Exist";
    } else if (parsed['contactNo'] != null) {
      return "Please provide valid mobile number";
    } else if (parsed['contactNo'] != null) {
      return "Mobile Number is already exist";
    }
    return "Fail";
    // print(response.body);
  }

  Future<bool> registeredBook(String body) async {
    http.Response response = await http.post(api + "postbook/",
        body: body,
        headers: {
          'authorization': basicAuth(),
          "Content-Type": "application/json"
        });

    var parsed = jsonDecode(response.body);

    if (parsed == "success") {
      return true;
      // Future.wait(base64Image.map((e) => http.post(api+"imagebook")));
    }

    return false;
  }

  Future<String> updateStudent(int id, String studentInfo) async {
    http.Response response = await http.put(api + "student/$id/",
        body: studentInfo,
        headers: {
          'authorization': basicAuth(),
          "Content-Type": "application/json"
        });
    var parsed = jsonDecode(response.body);
    if (parsed == "success") {
      return "true";
    }
    if (parsed['contactNo'] != null) {
      return "not valid";
    }
    return "false";
  }

  Future<bool> updateStudentPhoto(int id, String studentInfo) async {
    http.Response response = await http.put(api + "updatestudentphoto/$id/",
        body: studentInfo,
        headers: {
          'authorization': basicAuth(),
          "Content-Type": "application/json"
        });
    var parsed = jsonDecode(response.body);
    if (parsed == "success") {
      return true;
    }
    return false;
  }

  Future<List<Book>> getBookByPosted(int id) async {
    List<Book> bookList = new List();
    http.Response response =
        await http.get(api + 'bookbyposted/$id/', headers: {
      'authorization': basicAuth(),
    });
    var parsed = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var i in parsed) {
        bookList.add(Book.fromJson(i));
      }
    }
    return bookList;
  }

  Future<bool> editBook(int bookId, String editBookData) async {
    http.Response response = await http.put(api + 'book/$bookId/',
        body: editBookData,
        headers: {
          'authorization': basicAuth(),
          "Content-Type": "application/json"
        });
    var parsed = jsonDecode(response.body);
    if (parsed == "Success") {
      return true;
    }
    return false;
  }

  changePassword(int studId, String password, String newpassword) async {
    http.Response response =
        await http.post(api + 'changepass/$studId/', body: {
      "password": password,
      "newpassword": newpassword
    }, headers: {
      'authorization': basicAuth(),
    });
    var parsed = jsonDecode(response.body);
    if (parsed == "success") {
      return "Success";
    } else if (parsed == "Enter Right Old Password") {
      return "Enter Right Old Password";
    }
    return "Fail";
  }

  deleteStudent(int studId) async {
    http.Response response =
        await http.delete(api + 'student/$studId/', headers: {
      'authorization': basicAuth(),
    });
    // var parsed = jsonDecode(response.body);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  deleteBook(int bookId) async {
    http.Response response = await http.delete(api + 'book/$bookId/', headers: {
      'authorization': basicAuth(),
    });
    // var parsed = jsonDecode(response.body);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  deleteBookAndPost(String data) async {
    http.Response response =
        await http.post(api + 'purchasedbook/', body: data, headers: {
      "Content-Type": "application/json",
      'authorization': basicAuth(),
    });
    var parsed = jsonDecode(response.body);

    if (parsed == "Student doesn't exist with this contact Number") {
      return "Student doesn't exist with this contact Number";
    } else if (response.statusCode == 201) {
      return "Success";
    } else {
      return "Fail";
    }
  }

  purchasedBookByUser(int studId) async {
    // List<PurchasedBook> purchasedBook = new List();
    http.Response response = await http.get(
        api + "purchasedbookbyuser/$studId/",
        headers: {'authorization': basicAuth()});
    var parsed = jsonDecode(response.body);

    return parsed;
  }

  Future<dynamic> feedBack(String email, String message) async {
    final box = Hive.box("Student");
    http.Response response = await http.post(api + "feedback/", body: {
      "studName": box.get("studentName"),
      "email": email,
      "message": message
    }, headers: {
      'authorization': basicAuth()
    });
    var parsed = jsonDecode(response.body);

    return parsed;
  }

  Future<List<Book>> getHomeList() async {
    List<Book> book = new List();

    http.Response response = await http
        .get(api + 'homelist/', headers: {'authorization': basicAuth()});

    var parsed = jsonDecode(response.body);
    for (var i in parsed) {
      book.add(Book.fromJson(i));
    }
    return book;
  }

  Future<List<Book>> getLatestBook() async {
    List<Book> book = new List();

    http.Response response = await http
        .get(api + 'latestbook/', headers: {'authorization': basicAuth()});

    var parsed = jsonDecode(response.body);
    for (var i in parsed) {
      book.add(Book.fromJson(i));
    }
    return book;
  }

  updateImagePhoto(String bookImageInfo) async {
    http.Response response =
        await http.put(api + 'updatebookimage/', body: bookImageInfo, headers: {
      'authorization': basicAuth(),
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  addImageList(String bookImageInfo) async {
    http.Response response =
        await http.post(api + 'addimagelist/', body: bookImageInfo, headers: {
      'authorization': basicAuth(),
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  sendEmail(String body) async {
    http.Response response =
        await http.post(api + 'sendemail/', body: body, headers: {
      'authorization': basicAuth(),
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  updatePassword(String body) async {
    http.Response response =
        await http.put(api + 'updatepassword/', body: body, headers: {
      'authorization': basicAuth(),
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }
}
