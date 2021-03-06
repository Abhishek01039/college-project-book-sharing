import 'package:booksharing/core/models/image.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'book.g.dart';

@JsonSerializable(nullable: false)
class Book extends Equatable {
  Book(
      {this.bookId,
      this.bookName,
      this.authorName,
      this.pubName,
      this.isbnNo,
      this.originalPrice,
      this.price,
      this.edition,
      this.bookCatgName,
      this.postedBy,
      this.bookImage,
      this.postedDate})
      : assert(
          bookName != null,
          bookId != null,
        );

  final int bookId;
  final String bookName;
  final String authorName;
  final String pubName;
  final String isbnNo;
  final int originalPrice;
  final int price;
  final String edition;
  final String bookCatgName;
  final int postedBy;
  final List<BookImage> bookImage;
  final String postedDate;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object> get props => [
        bookId,
        bookName,
        authorName,
        pubName,
        isbnNo,
        originalPrice,
        price,
        edition,
        bookCatgName,
        postedBy,
        bookImage,
      ];
}
