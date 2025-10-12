part of 'app_controller_cubit.dart';

sealed class AppControllerState {
  const AppControllerState();
}

class Initial extends AppControllerState {
  const Initial();
}

class Authenticated extends AppControllerState {
  final UserModel userData;
  const Authenticated(this.userData);
}

class Unauthenticated extends AppControllerState {
  const Unauthenticated();
}

class AuthError extends AppControllerState {
  final String message;
  const AuthError(this.message);
}
