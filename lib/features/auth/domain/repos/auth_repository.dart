import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginEntity>> login({
    required String email,
    required String password,
  });

 

}
