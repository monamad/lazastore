import 'package:dio/dio.dart';
import 'package:lazastore/core/networking/api_error.dart';
// recources 
class ApiErrorHandler {
  static ApiError handleError<T>(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiError(
            message:
                'Connection timeout. Please check your internet connection.',
            statusCode: LocalStatusCode.connectionTimeout,
          );

        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);

        case DioExceptionType.cancel:
          return ApiError(
            message: 'Request was cancelled.',
            statusCode: LocalStatusCode.requestCancelled,
          );

        case DioExceptionType.connectionError:
          return ApiError(
            message: 'No internet connection. Please check your network.',
            statusCode: LocalStatusCode.noInternetConnection,
          );

        case DioExceptionType.badCertificate:
          return ApiError(
            message: 'Certificate error.',
            statusCode: LocalStatusCode.certificateError,
          );

        case DioExceptionType.unknown:
          return ApiError(
            message: 'Something went wrong. Please try again.',
            statusCode: LocalStatusCode.unknown,
          );
      }
    }

    return ApiError(
      message: error.toString(),
      statusCode: LocalStatusCode.unknown,
    );
  }

  static ApiError _handleBadResponse(Response? response) {
    if (response?.data != null && response != null) {
      try {
        return ApiError.fromJson(response.data);
      } catch (e) {
        return ApiError(
          message: 'Server error occurred',
          statusCode: response.statusCode ?? LocalStatusCode.serverError,
        );
      }
    }

    return ApiError(
      message: 'Unknown server error occurred',
      statusCode: response?.statusCode ?? LocalStatusCode.serverError,
    );
  }

  static String getErrorMessage(ApiError apiError) {
    if (apiError.errors != null && apiError.errors!.isNotEmpty) {
      final errorMessages = <String>[];
      apiError.errors!.forEach((field, messages) {
        errorMessages.addAll(messages);
      });
      return errorMessages.join('\n');
    }
    return apiError.message;
  }
}

class LocalStatusCode {
  static const int connectionTimeout = -1;
  static const int requestCancelled = -2;
  static const int noInternetConnection = -3;
  static const int certificateError = -4;
  static const int unknown = -5;
  static const int serverError = -6;

  // Common HTTP status codes
  static const int ok = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const int serviceUnavailable = 503;
}
