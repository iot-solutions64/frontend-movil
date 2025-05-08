import 'package:hydrosmart/core/global_variables.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/security/data/local/user_dao.dart';
import 'package:hydrosmart/features/security/data/local/user_model.dart';
import 'package:hydrosmart/features/security/data/remote/security_service.dart';
import 'package:hydrosmart/features/security/data/remote/user_dto.dart';
import 'package:hydrosmart/features/security/domain/user.dart';

class SecurityRepository {
  UserDao userDao = UserDao();

  Future<Resource<User>> login(String username, String password) async {
    Resource<UserDto> result = await SecurityService().login(username, password);

    if (result is Success) {
      GlobalVariables.userId = result.data!.userId;
      GlobalVariables.token = result.data!.token;
      insertUser(result.data!.userId, result.data!.username, result.data!.token);
      return Success(result.data!.toUser());
    } else {
      return Error(result.message!);
    }
  }

  Future<Resource> signUp(String username, String password, List<String> roles) async {
    Resource result = await SecurityService().signUp(username, password, roles);

    if (result is Success) {
      return Success(result.data);
    } else {
      return Error(result.message!);
    }
  }

  void logout() {
    userDao.deleteUser(GlobalVariables.userId);
    // Clear the global variables
    GlobalVariables.userId = 0;
    GlobalVariables.token = '';
  }

  void insertUser(int userId, String username, String token) {
    userDao.insertUser(UserModel(id: userId, username: username, token: token));
  }

  void deleteUser(int userId) {
    userDao.deleteUser(userId);
  }

  Future<Resource<UserModel>> getUser() async {
    List<UserModel> users = await userDao.getAllUsers();
    if (users.isNotEmpty) {
      GlobalVariables.userId = users[0].id;
      GlobalVariables.token = users[0].token;
      return Success(users[0]);
    } else {
      return Error('No user found');
    }
  }

}