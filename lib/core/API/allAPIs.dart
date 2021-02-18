import 'dart:convert';
import 'dart:developer';

import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/locator.dart';

import 'package:booksharing/core/models/book.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

const YOUR_SERVER_IP = '192.168.43.182';
const YOUR_SERVER_PORT = 8000;
mixin Api {
  String api = "http://192.168.43.182:8000/booksharing/";

  Future<List<Book>> getBooks() async {
    List<Book> book = new List();

    var response = await http.get(api + 'book/', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);
    print(parsed);

    if (parsed is Map) {
      if (parsed["detail"] == "Invalid token.") {
        return null;
      }
    }

    if (parsed.length != 0) {
      for (var i in parsed) {
        book.add(Book.fromJson(i));
      }

      return book;
    }
    return null;
  }

  getBooksById(int id) async {
    Book book = locator<Book>();

    var response = await http.get(api + 'book/$id', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);

    for (var i in parsed) {
      book = Book.fromJson(i);
    }

    return book;
  }

  Future<Student> getStudentById(int id) async {
    Student student = locator<Student>();

    http.Response response =
        await http.get("http://192.168.43.183:7700/denostud/$id");

    var parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      student = Student.fromJson(parsed[0]);
      return student;
    } else if (response.statusCode == 400) {
      log("User doesn't exist");
    }
    return null;
  }

  getBookImage(int id) async {
    List<BookImage> image = List<BookImage>();
    http.Response response = await http.get(api + 'imagebyid/$id', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      for (var i in parsed) {
        image.add(BookImage.fromJson(i));
      }
      return image;
    } else if (response.statusCode == 400) {
      log("Book Image is not exist");
    }
    return null;
  }

  Future<Student> logIn(String email, String pass) async {
    Student student = locator<Student>();

    http.Response response = await http.post(api + 'login/', body: {
      'email': email,
      "password": pass
    }, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      for (var i in parsed) {
        student = Student.fromJson(i);
      }
      final box = Hive.box("Student");

      box.put("ID", student.id);
      box.put("email", student.email);
      box.put("studentName", student.firstName);
      box.put("studentPhoto", "/media/" + student.photo);

      return student;
    }
    return null;
  }

  getPurchasedBook(String studId) async {
    http.Response response = await http.post(api + 'student/', body: {
      'studentId': studId
    }, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return parsed;
    }
    return null;
  }

  Future<String> registerStudent(
    String firstName,
    String lastName,
    String email,
    String age,
    String password,
    String address,
    String number,
    String base64Image,
    String extn,
  ) async {
    Student student = locator<Student>();
    http.Response response = await http.post(api + 'student/', body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "age": age,
      "password": password,
      "address": address,
      "contactNo": number,
      "photo": base64Image ?? "",
      "extansion": extn ?? ""
    }, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
    });
    var parsed = jsonDecode(response.body);

    if (response.statusCode == 201) {
      student = Student.fromJson(parsed);
      final box = Hive.box("Student");

      box.put("ID", student.id);
      box.put("email", student.email);
      box.put("studentName", student.firstName);
      box.put("studentPhoto", student.photo);

      return "Success";
    }

    if (parsed == "Student already Exist") {
      return "Student already Exist";
    } else if (parsed['contactNo'] != null) {
      return "Mobile Number is already exist";
    } else if (parsed['email'] != null) {
      return "Student with this email is already exist";
    }
    return "Fail";
  }

  Future<bool> registeredBook(String body) async {
    http.Response response =
        await http.post(api + "postbook/", body: body, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json"
    });

    var parsed = jsonDecode(response.body);

    if (parsed == "success") {
      return true;
    }

    return false;
  }

  Future<String> updateStudent(int id, String studentInfo) async {
    http.Response response =
        await http.put(api + "student/$id/", body: studentInfo, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
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
    http.Response response = await http
        .put(api + "updatestudentphoto/$id/", body: studentInfo, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
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
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
    });
    var parsed = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var i in parsed) {
        bookList.add(Book.fromJson(i));
      }
    }
    return bookList;
  }

  Future<String> editBook(int bookId, String editBookData) async {
    http.Response response =
        await http.put(api + 'book/$bookId/', body: editBookData, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json"
    });
    var parsed = jsonDecode(response.body);
    if (parsed == "Success") {
      return "true";
    }
    return "false";
  }

  changePassword(int studId, String password, String newpassword) async {
    http.Response response =
        await http.post(api + 'changepass/$studId/', body: {
      "password": password,
      "newpassword": newpassword
    }, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
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
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
    });

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  deleteBook(int bookId) async {
    http.Response response = await http.delete(api + 'book/$bookId/', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
    });

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  deleteBookAndPost(String data) async {
    http.Response response =
        await http.post(api + 'purchasedbook/', body: data, headers: {
      "Content-Type": "application/json",
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
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
    http.Response response =
        await http.get("http://192.168.43.183:7700/denopurchasedbook/$studId");
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
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });
    var parsed = jsonDecode(response.body);

    return parsed;
  }

  Future<List<Book>> getHomeList() async {
    List<Book> book = new List();

    http.Response response = await http.get(api + 'homelist/', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);
    for (var i in parsed) {
      book.add(Book.fromJson(i));
    }
    return book;
  }

  Future<List<Book>> getLatestBook() async {
    List<Book> book = new List();

    http.Response response = await http.get(api + 'latestbook/', headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93"
    });

    var parsed = jsonDecode(response.body);
    for (var i in parsed) {
      book.add(Book.fromJson(i));
    }
    return book;
  }

  updateImagePhoto(String bookImageInfo) async {
    http.Response response =
        await http.put(api + 'updatebookimage/', body: bookImageInfo, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  addImageList(String bookImageInfo) async {
    http.Response response =
        await http.post(api + 'addimagelist/', body: bookImageInfo, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  sendEmail(String body) async {
    http.Response response =
        await http.post(api + 'sendemail/', body: body, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }

  updatePassword(String body) async {
    http.Response response =
        await http.put(api + 'updatepassword/', body: body, headers: {
      'authorization': "Token 3157284fc6e1c38c9f3aa7e8ff659ef4ed03ef93",
      "Content-Type": "application/json",
    });

    var parsed = jsonDecode(response.body);
    return parsed;
  }
}
