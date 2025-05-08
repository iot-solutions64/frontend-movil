class UserModel {
  final int id;
  final String username;
  final String token;

  UserModel({
    required this.id,
    required this.username,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'token': token,
    };
  }
  
}