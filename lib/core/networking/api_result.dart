import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lazastore/core/networking/api_error.dart';

part 'api_result.freezed.dart';

@freezed
sealed class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ApiError apiError) = Failure;
}
