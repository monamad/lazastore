import 'package:get_it/get_it.dart';
import 'package:lazastore/core/di/modules/app_module.dart';
import 'package:lazastore/core/di/modules/auth_module.dart';
import 'package:lazastore/core/di/modules/home_module.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator() async {
  // Core modules first
  await AppModule.configure();

  // Feature modules
  AuthModule.configure();
  HomeModule.configure();
}
