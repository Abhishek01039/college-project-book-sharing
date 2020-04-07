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
    edition: json['edition'] as String,
    isbnNo: json['isbnNo'] as String,
    orginialPrice: json['orginialPrice'] as int,
    price: json['price'] as int,
    bookPhoto: json['bookPhoto'] as String,
    bookCatgName: json['bookCatgName'] as String,
    postedBy: json['postedBy'] as int,
    bookImage: (json['Book_Image'] as List)
        .map((e) => BookImage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'bookName': instance.bookName,
      'authorName': instance.authorName,
      'pubName': instance.pubName,
      'edition': instance.edition,
      'isbnNo': instance.isbnNo,
      'orginialPrice': instance.orginialPrice,
      'price': instance.price,
      'bookPhoto': instance.bookPhoto,
      'bookCatgName': instance.bookCatgName,
      'postedBy': instance.postedBy,
      'bookImage': instance.bookImage,
    };
