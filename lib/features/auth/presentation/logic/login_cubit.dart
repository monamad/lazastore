import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/Di/di_setup.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/app_controller/logic/app_controller_cubit.dart';
import 'package:lazastore/features/auth/domain/use_cases/login_use_case.dart';
import 'package:lazastore/features/auth/presentation/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(const LoginLoading());

    final result = await _loginUseCase(email: email, password: password);
    result.when(
      success: (loginData) async {
        emit(LoginSuccess(loginData));
        locator<AppControllerCubit>().checkAuthStatus();
      },
      failure: (error) {
        emit(LoginFailure(error.message));
      },
    );
  }
}
