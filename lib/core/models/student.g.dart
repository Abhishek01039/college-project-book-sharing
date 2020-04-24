// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final typeId = 1;

  @override
  Student read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as int,
      enrollmentNo: fields[1] as String,
      firstName: fields[2] as String,
      photo: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.photo);
  }
}

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
