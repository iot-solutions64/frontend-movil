abstract class LoginState {

  const LoginState();
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
}