abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String password;
  final List<String> roles = ['ROLE_USER'];

  RegisterSubmitted({required this.username, required this.password});
}