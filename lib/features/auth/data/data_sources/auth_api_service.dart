import 'package:dio/dio.dart';
import 'package:lazastore/core/models/user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lazastore/core/networking/api_constants.dart';
import 'package:lazastore/features/auth/data/models/login_request.dart';
import 'package:lazastore/features/auth/data/models/login_response.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiConstants.loginEndpoint)
  Future<LoginResponse> login(@Body() LoginRequest request);
  @GET(ApiConstants.meEndpoint)
  Future<UserModel> getMe();
}
