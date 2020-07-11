import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
// import 'package:booksharing/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with Api {
  ProfileBloc(ProfileState initialState) : super(initialState);

  ProfileState get initialState => ProfileInitial();
  final box = Hive.box("Student");

  @override
  void add(ProfileEvent event) {
    // ProfileBloc;
    super.add(event);
  }

  @override
  void onEvent(ProfileEvent event) {
    super.onEvent(event);
    // ProfileBloc.add(ProfileInitialEvent());
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    // ProfileBloc.add(ProfileInitialEvent());
    if (event is ProfileInitialEvent) {
      yield ProfileLoading();
      Student student = await getStudentProfile();
      yield ProfileLoaded(student: student);
    }
  }

  Future<Student> getStudentProfile() async {
    // Api api = locator<Api>();
    Student student = await getStudentById(box.get("ID"));
    // print(box.get('studentPhoto'));
    return student;
  }
}
