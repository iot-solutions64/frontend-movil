abstract class RegisterState {

  const RegisterState();
}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterError extends RegisterState {
  final String message;
  const RegisterError({required this.message});
}