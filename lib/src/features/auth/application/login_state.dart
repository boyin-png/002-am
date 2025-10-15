// lib/src/features/auth/application/login_state.dart
abstract class LoginState {}

class LoginInitial extends LoginState {
  final bool isRememberMeChecked;

  LoginInitial({this.isRememberMeChecked = false});

  LoginInitial copyWith({bool? isRememberMeChecked}) {
    return LoginInitial(
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
    );
  }
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
