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
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:booksharing/UI/views/changePassword.dart';
import 'package:booksharing/UI/views/feedBack.dart';
import 'package:provider/provider.dart';

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
