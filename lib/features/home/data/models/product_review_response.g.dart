// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewResponse _$ProductReviewResponseFromJson(
  Map<String, dynamic> json,
) => ProductReviewResponse(
  message: json['message'] as String?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
  reviews: json['reviews'] == null
      ? null
      : ReviewsPagination.fromJson(json['reviews'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductReviewResponseToJson(
  ProductReviewResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'averageRating': instance.averageRating,
  'reviewsCount': instance.reviewsCount,
  'reviews': instance.reviews,
};

ReviewsPagination _$ReviewsPaginationFromJson(Map<String, dynamic> json) =>
    ReviewsPagination(
      items: (json['items'] as List<dynamic>)
          .map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$ReviewsPaginationToJson(ReviewsPagination instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

ReviewItem _$ReviewItemFromJson(Map<String, dynamic> json) => ReviewItem(
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  userName: json['userName'] as String,
  userPicture: json['userPicture'] as String?,
);

Map<String, dynamic> _$ReviewItemToJson(ReviewItem instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'rating': instance.rating,
      'createdAt': instance.createdAt.toIso8601String(),
      'userName': instance.userName,
      'userPicture': instance.userPicture,
    };
