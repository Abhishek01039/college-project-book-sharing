import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'student.g.dart';

@JsonSerializable(nullable: false)
@HiveType(typeId: 1)
class Student extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(2)
  final String firstName;
  final String lastName;
  @HiveField(1)
  final String email;
  final int age;
  final String password;
  @HiveField(3)
  final String photo;
  final String contactNo;
  final String address;

  Student(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.age,
      this.password,
      this.photo,
      this.contactNo,
      this.address});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        age,
        password,
        photo,
        contactNo,
        address,
      ];
}
