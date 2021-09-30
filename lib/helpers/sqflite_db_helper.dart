import 'package:sqflite/sqflite.dart' as sqlflite;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sqlflite.Database> dataBase() async {
    final dbPath = await sqlflite.getDatabasesPath();
    return sqlflite.openDatabase(path.join(dbPath, 'great_places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.dataBase();
    sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sqlflite.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.dataBase();
    return sqlDb.query(table);
  }
}
