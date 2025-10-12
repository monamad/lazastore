import 'package:lazastore/core/di/di_setup.dart';
import 'package:lazastore/features/home/data/data_sources/home_api_service.dart';
import 'package:lazastore/features/home/data/repos/home_repository_impl.dart';
import 'package:lazastore/features/home/domain/repos/home_repository.dart';
import 'package:lazastore/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:lazastore/features/home/domain/use_cases/get_products_use_case.dart';

class HomeModule {
  static void configure() {
    // Data Layer
    locator.registerLazySingleton<HomeApiService>(
      () => HomeApiService(locator()),
    );

    // Domain Layer
    locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(locator()),
    );

    locator.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(locator()),
    );
    locator.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(locator()),
    );
  }
}
