import 'package:dio/dio.dart';
import 'package:lazastore/core/di/di_setup.dart';
import 'package:lazastore/core/networking/api_constants.dart';
import 'package:lazastore/core/storage_factory/cache_constants.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:lazastore/features/app_controller/logic/app_controller_cubit.dart';

class AuthInterceptor extends Interceptor {
  final StorageInterface storageFactory;
  AuthInterceptor({required this.storageFactory});
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the access token from secure storage
    final accessToken = await storageFactory.getSecure(
      StorageConstants.accessTokenKey,
    );

    // Add the token to the request headers if available
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _refreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final refreshToken = storageFactory.getString(
        StorageConstants.refreshTokenKey,
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        _handleLogout();
        handler.reject(e);
        return;
      }

      // Use the separate refresh Dio instance to avoid circular dependency
      // final response = await locator<Dio>(instanceName: 'refreshDio').post(
      //   ApiConstants.refreshTokenEndpoint,
      //   data: {'refreshToken': refreshToken},
      // );

      final response = await locator<Dio>().post(
        ApiConstants.refreshTokenEndpoint,
        data: {'refreshToken': refreshToken},
      );
      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      if (newAccessToken != null) {
        // Save the new tokens
        await storageFactory.saveSecure(
          StorageConstants.accessTokenKey,
          newAccessToken,
        );
        if (newRefreshToken != null) {
          await storageFactory.saveSecure(
            StorageConstants.refreshTokenKey,
            newRefreshToken,
          );
        }

        // Retry the original request with the new token
        e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // // Create a new dio instance to retry the request (avoiding circular dependency)
        // final retryDio = locator<Dio>();
        // retryDio.options = BaseOptions(
        //   baseUrl: ApiConstants.baseUrl,
        //   connectTimeout: const Duration(seconds: 30),
        //   receiveTimeout: const Duration(seconds: 30),
        //   sendTimeout: const Duration(seconds: 30),
        // );

        // final retryResponse = await retryDio.fetch(e.requestOptions);
        // handler.resolve(retryResponse);

        locator<Dio>().fetch(e.requestOptions);
      } else {
        _handleLogout();
        handler.reject(e);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401 ||
            error.response?.statusCode == 403) {
          // Refresh token is invalid or expired
          _handleLogout();
        }
      }
      handler.reject(e);
    }
  }

  void _handleLogout() {
    // Trigger logout in AppControllerCubit to update the app state
    final appControllerCubit = locator<AppControllerCubit>();
    appControllerCubit.logout();
  }
}
