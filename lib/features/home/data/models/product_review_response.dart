import 'package:json_annotation/json_annotation.dart';

part 'product_review_response.g.dart';

@JsonSerializable()
class ProductReviewResponse {
  final String? message;
  final double? averageRating;
  final int? reviewsCount;
  final ReviewsPagination? reviews;

  ProductReviewResponse({
    this.message,
    this.averageRating,
    this.reviewsCount,
    this.reviews,
  });

  factory ProductReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewResponseToJson(this);
}

@JsonSerializable()
class ReviewsPagination {
  final List<ReviewItem> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  ReviewsPagination({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ReviewsPagination.fromJson(Map<String, dynamic> json) =>
      _$ReviewsPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsPaginationToJson(this);
}

@JsonSerializable()
class ReviewItem {
  final String comment;
  final int rating;
  final DateTime createdAt;
  final String userName;
  final String? userPicture;

  ReviewItem({
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userName,
    this.userPicture,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) =>
      _$ReviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewItemToJson(this);
}