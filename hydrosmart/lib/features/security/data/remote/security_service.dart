import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/security/data/remote/signin_request.dart';
import 'package:hydrosmart/features/security/data/remote/signup_request.dart';
import 'package:hydrosmart/features/security/data/remote/user_dto.dart';

class SecurityService {
  Future<Resource<UserDto>> login(String username, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.baseUrl +
              AppConstants.signInEndpoint),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              SigninRequest(username: username, password: password).toMap()));

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        final userDto = UserDto.fromJson(json);
        return Success(userDto);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }

  Future<Resource> signUp(String username, String password, List<String> roles) async {
    try {
      http.Response response = await http.post(
          Uri.parse(AppConstants.baseUrl +
              AppConstants.signUpEndpoint),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              SignupRequest(username: username, password: password, roles: roles).toMap()));

      if (response.statusCode == HttpStatus.created) {
        final json = jsonDecode(response.body);
        final userId =json['id'];
        return Success(userId);
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      return Error('Error: ${error.toString()}');
    }
  }


}