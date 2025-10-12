import 'package:lazastore/features/auth/domain/entities/login_entity.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  const LoginSuccess(this.loginEntity);
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}

class LoginAlreadyLoggedIn extends LoginState {
  const LoginAlreadyLoggedIn();
}


