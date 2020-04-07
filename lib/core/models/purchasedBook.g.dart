// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchasedBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasedBook _$PurchasedBookFromJson(Map<String, dynamic> json) {
  return PurchasedBook(
    purId: json['purId'] as int,
    studId: json['studId'] as int,
    bookName: json['bookName'] as String,
    price: json['price'] as int,
    isbnNo: json['isbnNo'] as String,
  );
}

Map<String, dynamic> _$PurchasedBookToJson(PurchasedBook instance) =>
    <String, dynamic>{
      'purId': instance.purId,
      'studId': instance.studId,
      'bookName': instance.bookName,
      'price': instance.price,
      'isbnNo': instance.isbnNo,
    };
