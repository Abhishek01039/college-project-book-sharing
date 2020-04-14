import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/bookModel.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:booksharing/core/viewModels/studentLogInModel.dart';
import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booksharing/core/viewModels/purchasedBookModel.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => Book());
  locator.registerLazySingleton(() => StudentModel());
  locator.registerLazySingleton(() => BookModel());
  locator.registerLazySingleton(() => StudentEditModel());
  locator.registerLazySingleton(() => StudentRegModel());
  locator.registerLazySingleton(() => Student());
  locator.registerLazySingleton(() => BookImage());
  locator.registerLazySingleton(() => PurchasedBookModel());
  locator.registerLazySingleton(() async {
    return await SharedPreferences.getInstance();
  });
}
