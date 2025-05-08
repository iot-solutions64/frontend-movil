import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'security.db';
  final String tableName = 'users';

  Database? _db;

  Future<Database> openDb() async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query =
            'create table $tableName (id integer primary key, username text, token text)';
        db.execute(query);
      },
    );
    return _db as Database;
  }
}