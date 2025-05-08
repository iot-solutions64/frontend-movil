import 'package:hydrosmart/features/security/domain/user.dart';

class UserDto {
  final int userId;
  final String username;
  final String token;

  const UserDto({
    required this.userId,
    required this.username,
    required this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }

  User toUser(){
    return User(
      id: userId,
      username: username
    );
  }
}