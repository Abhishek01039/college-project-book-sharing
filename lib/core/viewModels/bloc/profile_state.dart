part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileLoaded extends ProfileState {
  final Student student;

  ProfileLoaded({this.student});

  @override
  List<Object> get props => throw UnimplementedError();
}
