import 'package:lazastore/core/storage_factory/cache_constants.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:lazastore/core/networking/api_error_handler.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/auth/data/data_sources/auth_api_service.dart';
import 'package:lazastore/features/auth/data/models/login_request.dart';
import 'package:lazastore/features/auth/domain/entities/login_entity.dart';
import 'package:lazastore/features/auth/domain/repos/auth_repository.dart';
import 'package:lazastore/core/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final StorageInterface _storageFactory;

  const AuthRepositoryImpl(this._apiService, this._storageFactory);

  @override
  Future<ApiResult<LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _apiService.login(request);

      final loginEntity = LoginEntity(
        accessToken: response.accessToken,
        expiresAtUtc: response.expiresAtUtc,
        refreshToken: response.refreshToken,
      );

      await _storageFactory.saveSecure(
        StorageConstants.accessTokenKey,
        response.accessToken,
      );
      await _storageFactory.saveSecure(
        StorageConstants.refreshTokenKey,
        response.refreshToken,
      );
      await _storageFactory.saveSecure(
        StorageConstants.accessTokenExpiresAtKey,
        response.expiresAtUtc,
      );
      final userdata = await getUserData();
      await _storageFactory.saveObject(StorageConstants.userDataKey, userdata);
      return Success(loginEntity);
    } catch (error) {
      await _storageFactory.clearAll();
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    final response = await _apiService.getMe();
    final userData = UserModel(
      userId: response.userId,
      fullName: response.fullName,
      email: response.email,
      profilePicture: response.profilePicture ?? '',
    );
    return userData.toJson();
  }
}
