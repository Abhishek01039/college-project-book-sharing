import 'package:booksharing/UI/views/book_screens/allBooks.dart';
import 'package:booksharing/UI/views/book_screens/bookDelete.dart';
import 'package:booksharing/UI/views/book_screens/bookDetail.dart';
import 'package:booksharing/UI/views/book_screens/bookEdit.dart';
import 'package:booksharing/UI/views/student_screens/changePasswordAfterOTP.dart';
import 'package:booksharing/UI/views/student_screens/enterOTP.dart';
import 'package:booksharing/UI/views/student_screens/forgetPassword.dart';
import 'package:booksharing/UI/views/homeScreen.dart';
import 'package:booksharing/UI/views/student_screens/loginScreen.dart';
import 'package:booksharing/UI/views/book_screens/myPostedBook.dart';
import 'package:booksharing/UI/views/book_screens/myPostedBookDetail.dart';
import 'package:booksharing/UI/views/book_screens/myPurchasedBook.dart';
import 'package:booksharing/UI/views/book_screens/postedBook.dart';
import 'package:booksharing/UI/views/student_screens/postedByProfile.dart';
import 'package:booksharing/UI/views/student_screens/profilePage.dart';
import 'package:booksharing/UI/views/student_screens/registration.dart';
import 'package:booksharing/UI/views/splashScreen.dart';
import 'package:booksharing/UI/views/student_screens/studentEdit.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/student_screens/changePassword.dart';
import 'package:booksharing/UI/views/student_screens/feedBack.dart';

const String initialRoute = "/";

// This all are the Routers
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MySpalshScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
        break;
      case 'allBooks':
        return MaterialPageRoute(builder: (context) {
          return AllBooks();
        });
        break;
      case 'login':
        return MaterialPageRoute(builder: (_) => LogIn());
        break;
      case 'registration':
        return MaterialPageRoute(builder: (_) => Registration());
        break;
      case 'bookDetail':
        return MaterialPageRoute(builder: (_) => BookDetail());
        break;
      case 'profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
        break;
      case 'postedByProfile':
        return MaterialPageRoute(builder: (_) => PostedByProfilePage());
        break;
      case 'myPostedBook':
        return MaterialPageRoute(builder: (_) => MyPostedBook());
        break;
      case 'postedBook':
        return MaterialPageRoute(builder: (_) => PostedBook());
        break;
      case 'studentEdit':
        return MaterialPageRoute(builder: (_) => StudentEdit());
        break;
      case 'bookedit':
        return MaterialPageRoute(builder: (_) => BookEdit());
        break;
      case 'changePassword':
        return MaterialPageRoute(builder: (_) => ChangePassword());
        break;
      case 'bookdelete':
        return MaterialPageRoute(builder: (_) => BookDelete());
        break;
      case 'myPurchasedBook':
        return MaterialPageRoute(builder: (_) => MyPurchasedBook());
        break;
      case 'feedback':
        return MaterialPageRoute(builder: (_) => FeedBack());
        break;
      case 'myPostedBookDetail':
        return MaterialPageRoute(builder: (_) => MyPostedBookDetail());
        break;
      case 'forgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPassword());
        break;
      case 'enterOTP':
        return MaterialPageRoute(builder: (_) => EnterOTP());
        break;
      case 'changePasswordAfterOTP':
        return MaterialPageRoute(builder: (_) => ChangePasswordAfterOTP());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
        break;
    }
  }
}
