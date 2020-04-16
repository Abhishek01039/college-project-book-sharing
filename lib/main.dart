import 'package:booksharing/UI/router.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:booksharing/core/viewModels/postedBookModel.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:booksharing/core/viewModels/studentLogInModel.dart';
import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:booksharing/locator.dart';
import 'package:booksharing/core/viewModels/bookDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booksharing/core/viewModels/purchasedBookModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // run app if and if only device in protrait mode not landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // WidgetsFlutterBinding.ensureInitialized();

    //  get the shared preference instance
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      SPHelper.setPref(sp);
      // print(SPHelper.getInt("DarkTheme"));
      setupLocator();
      if (sp.getBool("DarkTheme") == null) {
        sp.setBool("DarkTheme", false);
      }
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
        ChangeNotifierProvider(create: (_) => StudentEditModel()),
        ChangeNotifierProvider(create: (_) => PurchasedBookModel()),
      ],
      child: Consumer<BaseModel>(
        builder: (context, basemodel, _) {
          return MaterialApp(
            // darkTheme: ThemeData(

            // ),
            // Theme and color choosen by the article of google material design 
            theme: SPHelper.getBool("DarkTheme")
                ? ThemeData(
                    primaryColor: Color(0xFF121212),
                    // accentColor: c,
                    textTheme: TextTheme(
                      bodyText1: TextStyle(
                        color: Color(0xFFFFFF).withOpacity(0.87),
                      ),
                      headline2: TextStyle(
                        color: Color(0xFFFFFF).withOpacity(0.87),
                      ),
                      caption: TextStyle(
                        color: Color(0xFFFFFF).withOpacity(0.6),
                      ),
                      subtitle2: TextStyle(color: Colors.white),
                    ),
                    errorColor: Colors.red.withOpacity(0.30),
                    brightness: Brightness.dark)

                    // TODO choose color properly
                : ThemeData(
                    primaryColor: Color(0xFF313457),
                    accentColor: Color(0xFF5888D9),
                    brightness: Brightness.light,
                  ),

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
