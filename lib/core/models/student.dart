import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'student.g.dart';

@JsonSerializable(nullable: false)
@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String enrollmentNo;
  @HiveField(2)
  final String firstName;
  final String lastName;

  final String email;
  final int age;
  final String collegeName;
  final int collegeYear;
  final String course;
  final String password;
  @HiveField(3)
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
