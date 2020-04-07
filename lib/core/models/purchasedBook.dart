import 'package:json_annotation/json_annotation.dart';
part 'purchasedBook.g.dart';

@JsonSerializable(nullable: false)
class PurchasedBook {
  final int purId;
  final int studId;
  final String bookName;
  final int price;
  final String isbnNo;

  PurchasedBook(
      {this.purId, this.studId, this.bookName, this.price, this.isbnNo});

  factory PurchasedBook.fromJson(Map<String, dynamic> json) =>
      _$PurchasedBookFromJson(json);
  Map<String, dynamic> toJson() => _$PurchasedBookToJson(this);
}
