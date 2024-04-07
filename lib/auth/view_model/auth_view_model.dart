import 'package:chat/auth/view_model/auth_states.dart';
import 'package:chat/auth/data/models/user_model.dart';
import 'package:chat/shared/database_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<AuthState> {
  AuthViewModel() : super(AuthInitial());

  UserModel? currentUser;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      currentUser = await DatabaseUtils.register(
        name: name,
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      currentUser = await DatabaseUtils.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await DatabaseUtils.logout();
      currentUser = null;
      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutError(error.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await DatabaseUtils.getCurrentUser();
      if (currentUser != null) {
        emit(IsLoggedIn());
      } else {
        emit(NotLoggedIn());
      }
    } catch (_) {
      emit(NotLoggedIn());
    }
  }
}
