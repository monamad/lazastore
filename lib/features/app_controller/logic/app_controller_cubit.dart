import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/features/app_controller/data/App_control_repo.dart';
import 'package:lazastore/core/models/user_model.dart';
part 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  final AppControlRepo appControlRepo;
  AppControllerCubit(this.appControlRepo) : super(const Initial());

  Future<void> checkAuthStatus() async {
    try {
      final isValid = await appControlRepo.hasTokenAndValid();
      print(isValid);
      if (isValid == null) {
        emit(const Unauthenticated());
        return;
      }
      if (isValid == true) {
        final userData = appControlRepo.getUserData();
        if (userData != null) {
          emit(Authenticated(userData));
          return;
        }
      }
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await appControlRepo.clearTokens();
    emit(const Unauthenticated());
  }
}
