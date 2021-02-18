import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'purchasedBook.g.dart';

@JsonSerializable(nullable: false)
class PurchasedBook extends Equatable {
  PurchasedBook(
      {this.purId, this.studId, this.bookName, this.price, this.isbnNo})
      : assert(
          studId != null,
        );

  final int purId;
  final int studId;
  final String bookName;
  final int price;
  final String isbnNo;

  factory PurchasedBook.fromJson(Map<String, dynamic> json) =>
      _$PurchasedBookFromJson(json);
  Map<String, dynamic> toJson() => _$PurchasedBookToJson(this);

  @override
  List<Object> get props => [
        purId,
        studId,
        bookName,
        price,
        isbnNo,
      ];
}
