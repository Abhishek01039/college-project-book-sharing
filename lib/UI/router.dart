import 'package:booksharing/UI/views/allBooks.dart';
import 'package:booksharing/UI/views/bookDelete.dart';
import 'package:booksharing/UI/views/bookDetail.dart';
import 'package:booksharing/UI/views/bookEdit.dart';
import 'package:booksharing/UI/views/homeScreen.dart';
import 'package:booksharing/UI/views/loginScreen.dart';
import 'package:booksharing/UI/views/myPostedBook.dart';
import 'package:booksharing/UI/views/myPurchasedBook.dart';
import 'package:booksharing/UI/views/postedBook.dart';
import 'package:booksharing/UI/views/postedByProfile.dart';
import 'package:booksharing/UI/views/profilePage.dart';
import 'package:booksharing/UI/views/registration.dart';
import 'package:booksharing/UI/views/splashScreen.dart';
import 'package:booksharing/UI/views/studentEdit.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/changePassword.dart';
import 'package:booksharing/UI/views/feedBack.dart';

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
      case 'allBooks':
        return MaterialPageRoute(builder: (_) => AllBooks());
      case 'login':
        return MaterialPageRoute(builder: (_) => LogIn());
      case 'registration':
        return MaterialPageRoute(builder: (_) => Registration());
      case 'bookDetail':
        return MaterialPageRoute(builder: (_) => BookDetail());
      case 'profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case 'postedByProfile':
        return MaterialPageRoute(builder: (_) => PostedByProfilePage());
      case 'myPostedBook':
        return MaterialPageRoute(builder: (_) => MyPostedBook());
      case 'postedBook':
        return MaterialPageRoute(builder: (_) => PostedBook());
      case 'studentEdit':
        return MaterialPageRoute(builder: (_) => StudentEdit());
      case 'bookedit':
        return MaterialPageRoute(builder: (_) => BookEdit());
      case 'changePassword':
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case 'bookdelete':
        return MaterialPageRoute(builder: (_) => BookDelete());
      case 'myPurchasedBook':
        return MaterialPageRoute(builder: (_) => MyPurchasedBook());
      case 'feedback':
      return MaterialPageRoute(builder: (_) => FeedBack());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
