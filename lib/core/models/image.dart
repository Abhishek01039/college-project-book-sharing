import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image.g.dart';

@JsonSerializable(nullable: false)
class BookImage extends Equatable {
  BookImage({this.bookId, this.image})
      : assert(
          bookId != null,
          image != null,
        );

  final int bookId;
  final String image;

  factory BookImage.fromJson(Map<String, dynamic> json) =>
      _$BookImageFromJson(json);
  Map<String, dynamic> toJson() => _$BookImageToJson(this);

  @override
  List<Object> get props => [bookId, image];
}
