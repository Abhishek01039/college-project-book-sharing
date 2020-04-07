// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    id: json['id'] as int,
    enrollmentNo: json['enrollmentNo'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    age: json['age'] as int,
    collegeName: json['collegeName'] as String,
    collegeYear: json['collegeYear'] as int,
    course: json['course'] as String,
    password: json['password'] as String,
    photo: json['photo'] as String,
    contactNo: json['contactNo'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'enrollmentNo': instance.enrollmentNo,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'age': instance.age,
      'collegeName': instance.collegeName,
      'collegeYear': instance.collegeYear,
      'course': instance.course,
      'password': instance.password,
      'photo': instance.photo,
      'contactNo': instance.contactNo,
      'address': instance.address,
    };
