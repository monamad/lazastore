import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/auth/domain/entities/login_entity.dart';
import 'package:lazastore/features/auth/domain/repos/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<ApiResult<LoginEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
