import 'package:dio/dio.dart';
import 'package:lazastore/core/di/di_setup.dart';
import 'package:lazastore/core/networking/resources/dio_factory.dart';
import 'package:lazastore/features/auth/data/data_sources/auth_api_service.dart';
import 'package:lazastore/features/auth/data/repos/auth_repository_impl.dart';
import 'package:lazastore/features/auth/domain/repos/auth_repository.dart';
import 'package:lazastore/features/auth/domain/use_cases/login_use_case.dart';
import 'package:lazastore/features/auth/presentation/logic/login_cubit.dart';

class AuthModule {
  static void configure() {


    locator.registerLazySingleton<Dio>(
      () => DioFactory(locator()).createAppDio(),
    );

    // Refresh Token Dio instance (separate instance to prevent circular dependency)
    // locator.registerLazySingleton<Dio>(
    //   () => DioFactory.createRefreshDio(),
    //   instanceName: 'refreshDio',
    // );

    // API Service
    locator.registerLazySingleton<AuthApiService>(
      () => AuthApiService(locator()),
    );

    // Repository
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator(), locator()),
    );

    // Use Cases
    locator.registerLazySingleton(() => LoginUseCase(locator()));

    // Cubit
    locator.registerFactory(() => LoginCubit(locator<LoginUseCase>()));
  }
}
