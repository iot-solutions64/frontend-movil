import 'package:hydrosmart/features/security/domain/user.dart';

class UserDto {
  final int id;
  final String username;
  final String token;

  const UserDto({
    required this.id,
    required this.username,
    required this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }

  User toUser(){
    return User(
      id: id,
      username: username
    );
  }
}