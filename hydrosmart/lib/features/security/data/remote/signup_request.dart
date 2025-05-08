class SignupRequest {
  final String username;
  final String password;
  final List<String> roles;

  const SignupRequest({
    required this.username,
    required this.password,
    required this.roles,
  });

  Map<String, dynamic> toMap(){
    return {
      'username': username,
      'password': password,
      'roles': roles
    };
  }
}