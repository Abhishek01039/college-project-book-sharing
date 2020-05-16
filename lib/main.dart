import 'package:booksharing/UI/router.dart';
import 'package:booksharing/config/flavor_config.dart';

import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/bloc/profile_bloc.dart';
import 'package:booksharing/core/viewModels/book_provider/bookEditModel.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:booksharing/core/viewModels/book_provider/postedBookModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentLogInModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:booksharing/locator.dart';
import 'package:booksharing/core/viewModels/book_provider/bookDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/book_provider/purchasedBookModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:booksharing/core/viewModels/bloc/profile_bloc_delegate.dart';

// import '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // run app if and if only device in protrait mode not landscape mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((_) {
  // WidgetsFlutterBinding.ensureInitialized();

  //  get the shared preference instance
  // var path = Directory.current.path;
  // Hive
  //   ..init(path)
  //   ..registerAdapter(StudentAdapter());
  await Hive.initFlutter();
  await Hive.openBox('Student');
  await Hive.openBox('DarkTheme');
  FlavorConfig(flavor: Flavor.PRODUCTION);
  setupLocator();
  BlocSupervisor.delegate = locator<SimpleBlocDelegate>();
  runApp(MyApp());

  // });
}

class MyApp extends StatelessWidget {
  final darkTheme = Hive.box("DarkTheme");
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseModel()),
        ChangeNotifierProvider(create: (_) => BookModel()),
        ChangeNotifierProvider(create: (_) => StudentModel()),
        ChangeNotifierProvider(create: (_) => StudentRegModel()),
        ChangeNotifierProvider(create: (_) => PostedBookModel()),
        ChangeNotifierProvider(create: (_) => PostedBookEditModel()),
        ChangeNotifierProvider(create: (_) => BookDetailModel()),
        ChangeNotifierProvider(create: (_) => StudentEditModel()),
        ChangeNotifierProvider(create: (_) => PurchasedBookModel()),
      ],
      child: BlocProvider(
        create: (_) => ProfileBloc(),
        // lazy: ,
        child: Consumer<BaseModel>(
          builder: (context, basemodel, _) {
            return MaterialApp(
              // darkTheme: ThemeData(

              // ),
              // Theme and color choosen by the article of google material design
              theme: darkTheme.get("darkTheme", defaultValue: false)
                  ? ThemeData(
                      // backgroundColor: Colors.,
                      primaryColor: Color(0xFF121212),
                      // accentColor: Colors.blue[300],
                      buttonTheme: ButtonThemeData(
                          // buttonColor: Colors.teal[200],
                          ),
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
                      errorColor: Colors.red.withOpacity(0.80),
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: Colors.teal[200],
                      ),
                      brightness: Brightness.dark)

                  // TODO choose color properly
                  : ThemeData(
                      primaryColor: Color(0xFF313457),
                      accentColor: Color(0xFF5888D9),

                      textTheme: TextTheme(
                        button: TextStyle(
                            // fontSize: 50,
                            // foreground: Paint()..color = Colors.white,
                            // color: Colors.blue,
                            ),
                      ),
                      // buttonColor: Color(0xFF313457),
                      backgroundColor: Color(0xfffffffff),
                      buttonTheme: ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                        buttonColor: Color(0xFF313457),
                      ),
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: Color(0xFF313457),
                      ),
                      brightness: Brightness.light,
                    ),

              title: 'Book Sharing',
              // home: LogIn(),
              initialRoute: '/',
              onGenerateRoute: Router.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
