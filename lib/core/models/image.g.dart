// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookImage _$BookImageFromJson(Map<String, dynamic> json) {
  return BookImage(
    bookId: json['bookId'] as int,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$BookImageToJson(BookImage instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'image': instance.image,
    };
