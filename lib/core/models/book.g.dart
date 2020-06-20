// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    bookId: json['bookId'] as int,
    bookName: json['bookName'] as String,
    authorName: json['authorName'] as String,
    pubName: json['pubName'] as String,
    isbnNo: json['isbnNo'] as String,
    originalPrice: json['originalPrice'] as int,
    price: json['price'] as int,
    bookCatgName: json['bookCatgName'] as String,
    edition: json['edition'] as String,
    postedBy: json['postedBy'] as int,
    bookImage: (json['Book_Image'] as List)
        .map((e) => BookImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    postedDate: json['postedDate'] as String,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'bookName': instance.bookName,
      'authorName': instance.authorName,
      'pubName': instance.pubName,
      'isbnNo': instance.isbnNo,
      'originalPrice': instance.originalPrice,
      'price': instance.price,
      "edition": instance.edition,
      'bookCatgName': instance.bookCatgName,
      'postedBy': instance.postedBy,
      'bookImage': instance.bookImage,
      'postedDate': instance.postedDate,
    };
