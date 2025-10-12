import 'package:dio/dio.dart';
import 'package:lazastore/core/networking/api_constants.dart';
import 'package:lazastore/core/networking/auth_interceptor.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  StorageInterface storageFactory;
  DioFactory(this.storageFactory);
  // Static instances
  //static Dio? _appDio;
  //static Dio? _refreshDio;

  /// Creates the main app Dio instance with auth interceptor
  Dio createAppDio() {
    final appDio = Dio();

    appDio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add auth interceptor for automatic token handling
    appDio.interceptors.add(AuthInterceptor(storageFactory: storageFactory));

    // Add logger interceptor only in debug mode
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      appDio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          compact: false,
          maxWidth: 90,
        ),
      );
    }

    return appDio;
  }

  // /// Creates a separate Dio instance for refresh token operations
  // /// This prevents circular dependency when refreshing tokens
  // static Dio createRefreshDio() {
  //   if (_refreshDio != null) return _refreshDio!;

  //   _refreshDio = Dio();

  //   _refreshDio!.options = BaseOptions(
  //     baseUrl: ApiConstants.baseUrl,
  //     connectTimeout: const Duration(seconds: 30),
  //     receiveTimeout: const Duration(seconds: 30),
  //     sendTimeout: const Duration(seconds: 30),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   // Add logger interceptor only in debug mode for refresh dio as well
  //   if (const bool.fromEnvironment('dart.vm.product') == false) {
  //     _refreshDio!.interceptors.add(
  //       PrettyDioLogger(
  //         requestHeader: true,
  //         requestBody: true,
  //         responseHeader: false,
  //         responseBody: true,
  //         compact: false,
  //         maxWidth: 90,
  //       ),
  //     );
  //   }

  //   return _refreshDio!;
  // }
}
