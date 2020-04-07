import 'package:booksharing/UI/router.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:booksharing/core/viewModels/postedBookModel.dart';
import 'package:booksharing/core/viewModels/studentLogInModel.dart';
import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:booksharing/locator.dart';
import 'package:booksharing/core/viewModels/bookDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      SPHelper.setPref(sp);
      setupLocator();
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseModel()),
        ChangeNotifierProvider(create: (_) => BookModel()),
        ChangeNotifierProvider(create: (_) => StudentModel()),
        ChangeNotifierProvider(create: (_) => StudentRegModel()),
        ChangeNotifierProvider(create: (_) => PostedBookModel()),
        ChangeNotifierProvider(create: (_) => BookDetailModel()),
      ],
      child: Consumer<BaseModel>(
        builder: (context, basemodel, child) {
          return MaterialApp(
            title: 'Book Sharing',
            // home: LogIn(),
            initialRoute: '/',
            onGenerateRoute: Router.generateRoute,
          );
        },
      ),
    );
  }
}
