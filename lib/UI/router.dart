import 'package:booksharing/UI/views/book_screens/allBooks.dart';
import 'package:booksharing/UI/views/book_screens/bookDelete.dart';
import 'package:booksharing/UI/views/book_screens/bookDetail.dart';
import 'package:booksharing/UI/views/book_screens/bookEdit.dart';
import 'package:booksharing/UI/views/book_screens/filterBook.dart';
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
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/student_screens/changePassword.dart';
import 'package:booksharing/UI/views/student_screens/feedBack.dart';

const String initialRoute = "/";

// This all are the Routers
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) {
          return MySpalshScreen();
        });
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
        break;
      case RoutePaths.AllBook:
        return MaterialPageRoute(builder: (context) {
          return AllBooks();
        });
        break;
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) {
          return LogIn();
        });
        break;
      case RoutePaths.Register:
        return MaterialPageRoute(builder: (_) {
          return Registration();
        });
        break;
      case RoutePaths.BookDetail:
        return MaterialPageRoute(builder: (_) {
          return BookDetail();
        });
        break;
      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) {
          return ProfilePage();
        });
        break;
      case RoutePaths.PostedByProfile:
        return MaterialPageRoute(builder: (_) {
          return PostedByProfilePage();
        });
        break;
      case RoutePaths.MyPostedBook:
        return MaterialPageRoute(builder: (_) {
          return MyPostedBook();
        });
        break;
      case RoutePaths.PostedBook:
        return MaterialPageRoute(builder: (_) {
          return PostedBook();
        });
        break;
      case RoutePaths.StudentEdit:
        return MaterialPageRoute(builder: (_) {
          return StudentEdit();
        });
        break;
      case RoutePaths.Bookedit:
        return MaterialPageRoute(builder: (_) {
          return BookEdit();
        });
        break;
      case RoutePaths.ChangePassword:
        return MaterialPageRoute(builder: (_) {
          return ChangePassword();
        });
        break;
      case RoutePaths.Bookdelete:
        return MaterialPageRoute(builder: (_) {
          return BookDelete();
        });
        break;
      case RoutePaths.MyPurchasedBook:
        return MaterialPageRoute(builder: (_) {
          return MyPurchasedBook();
        });
        break;
      case RoutePaths.Feedback:
        return MaterialPageRoute(builder: (_) {
          return FeedBack();
        });
        break;
      case RoutePaths.MyPostedBookDetail:
        return MaterialPageRoute(builder: (_) {
          return MyPostedBookDetail();
        });
        break;
      case RoutePaths.ForgetPassword:
        return MaterialPageRoute(builder: (_) {
          return ForgetPassword();
        });
        break;
      case RoutePaths.EnterOTP:
        return MaterialPageRoute(builder: (_) {
          return EnterOTP();
        });
        break;
      case RoutePaths.ChangePasswordAfterOTP:
        return MaterialPageRoute(builder: (_) {
          return ChangePasswordAfterOTP();
        });
        break;
      case RoutePaths.FilterBook:
        return MaterialPageRoute(builder: (_) {
          return FilterBook();
        });
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
