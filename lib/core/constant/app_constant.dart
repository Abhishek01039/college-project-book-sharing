import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  static const String Splash = '/';
  static const String Login = 'login';
  static const String Register = 'registration';
  static const String Profile = 'profile';
  static const String Home = 'home';
  static const String AllBook = "allBooks";
  static const String BookDetail = "bookDetail";
  static const String PostedByProfile = "postedByProfile";
  static const String MyPostedBook = "myPostedBook";
  static const String PostedBook = "postedBook";
  static const String StudentEdit = "studentEdit";
  static const String Bookedit = "bookedit";
  static const String ChangePassword = "changePassword";
  static const String Bookdelete = "bookdelete";
  static const String MyPurchasedBook = "myPurchasedBook";
  static const String Feedback = "feedback";
  static const String MyPostedBookDetail = "myPostedBookDetail";
  static const String ForgetPassword = "forgetPassword";
  static const String EnterOTP = "enterOTP";
  static const String FilterBook = "filterBook";
  static const String ChangePasswordAfterOTP = "changePasswordAfterOTP";
}

enum Flavor { DEV, QA, PRODUCTION }

class ColorMaterial {
  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}
