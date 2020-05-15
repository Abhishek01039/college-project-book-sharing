import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/book.dart';
import 'package:booksharing/core/models/image.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/core/viewModels/bloc/profile_bloc.dart';
import 'package:booksharing/core/viewModels/bloc/profile_bloc_delegate.dart';
import 'package:booksharing/core/viewModels/book_provider/bookEditModel.dart';
import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentLogInModel.dart';
import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:get_it/get_it.dart';
import 'package:booksharing/core/viewModels/book_provider/purchasedBookModel.dart';

GetIt locator = GetIt.instance;
// this all are the Lazy Singleton
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
  locator.registerLazySingleton(() => PostedBookEditModel());
  locator.registerLazySingleton(() => PurchasedBookModel());
  locator.registerLazySingleton(() => ProfileBloc());
  locator.registerLazySingleton(() => ProfileLoading());
  locator.registerLazySingleton(() => ProfileLoaded());
  locator.registerLazySingleton(() => ProfileInitial());
  locator.registerLazySingleton(() => SimpleBlocDelegate());
  locator.registerLazySingleton(() => ProfileInitialEvent());
}
