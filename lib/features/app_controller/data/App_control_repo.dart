import 'package:lazastore/core/storage_factory/cache_constants.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:lazastore/core/models/user_model.dart';

class AppControlRepo {
  StorageInterface storageFactory;
  AppControlRepo({required this.storageFactory});

  Future<bool?> hasTokenAndValid() async {
    try {
      final accessTokenKey = await storageFactory.getSecure(
        StorageConstants.accessTokenKey,
      );

      if (accessTokenKey == null) return null;

      final accessTokenExpiresAtKey = await storageFactory.getSecure(
        StorageConstants.accessTokenExpiresAtKey,
      );

      final expiresAt = DateTime.tryParse(accessTokenExpiresAtKey!);

      if (expiresAt == null) return false;
      if (DateTime.now().isAfter(expiresAt)) {
        print('Token expired');
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> clearTokens() async {
    await storageFactory.clearSecure();
  }

  UserModel? getUserData() {
    final userData = storageFactory.getObject(StorageConstants.userDataKey);
    return userData != null ? UserModel.fromJson(userData) : null;
  }
}
