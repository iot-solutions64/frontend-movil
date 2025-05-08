class SigninRequest {
  final String username;
  final String password;

  const SigninRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap(){
    return {
      'username': username,
      'password': password
    };
  }
}