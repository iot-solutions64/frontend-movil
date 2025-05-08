import 'package:hydrosmart/features/security/data/local/user_model.dart';
import 'package:hydrosmart/shared/data/local/app_database.dart';

class UserDao {
  
  Future<void> insertUser(UserModel user) async {
    final db = await AppDatabase().openDb();
    await db.insert(AppDatabase().tableName, user.toMap());
  }

  Future<void> deleteUser(int id) async {
    final db = await AppDatabase().openDb();
    await db.delete(AppDatabase().tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await AppDatabase().openDb();
    var users = await db.query(AppDatabase().tableName);
    return users.map((user) => UserModel.fromMap(user)).toList();
  }
}