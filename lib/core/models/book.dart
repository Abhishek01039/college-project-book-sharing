import 'package:booksharing/core/models/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(nullable: false)
class Book {
  final int bookId;
  final String bookName;
  final String authorName;
  final String pubName;
  final String edition;
  final String isbnNo;
  final int orginialPrice;
  final int price;
  final String bookPhoto;
  final String bookCatgName;
  final int postedBy;
  final List<BookImage> bookImage;

  Book(
      {this.bookId,
      this.bookName,
      this.authorName,
      this.pubName,
      this.edition,
      this.isbnNo,
      this.orginialPrice,
      this.price,
      this.bookPhoto,
      this.bookCatgName,
      this.postedBy,
      this.bookImage});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
