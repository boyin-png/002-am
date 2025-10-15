// lib/src/features/auth/application/login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void toggleRememberMe(bool newValue) {
    if (state is LoginInitial) {
      emit((state as LoginInitial).copyWith(isRememberMeChecked: newValue));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simula una llamada de red

    if (email == 'test@javerage.com' && password == '5ecret4') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error: 'Credenciales inválidas. Inténtalo de nuevo.'));
    }
  }
}
