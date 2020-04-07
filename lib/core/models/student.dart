import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable(nullable: false)
class Student {
  final int id;
  final String enrollmentNo;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final String collegeName;
  final int collegeYear;
  final String course;
  final String password;
  final String photo;
  final String contactNo;
  final String address;

  Student(
      {this.id,
      this.enrollmentNo,
      this.firstName,
      this.lastName,
      this.email,
      this.age,
      this.collegeName,
      this.collegeYear,
      this.course,
      this.password,
      this.photo,
      this.contactNo,
      this.address});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
