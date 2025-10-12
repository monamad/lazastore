import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazastore/core/di/di_setup.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:lazastore/core/storage_factory/storage_factory_impl.dart';
import 'package:lazastore/features/app_controller/data/App_control_repo.dart';
import 'package:lazastore/features/app_controller/logic/app_controller_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule {
  static Future<void> configure() async {
    final prefs = await SharedPreferences.getInstance();

    locator.registerLazySingleton<StorageInterface>(
      () => StorageFactory(
        secureStorage: const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
        prefs: prefs,
      ),
    );

    locator.registerLazySingleton<AppControlRepo>(
      () => AppControlRepo(storageFactory: locator<StorageInterface>()),
    );
    locator.registerLazySingleton<AppControllerCubit>(
      () => AppControllerCubit(locator<AppControlRepo>()),
    );
  }
}
