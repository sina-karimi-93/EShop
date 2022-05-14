import 'package:sqflite/sqflite.dart' as db;
import 'package:path/path.dart' as path;

class DatabaseHandler {
  /*
  This class contains several static method for interacting
  to local database. Desired database is sqflite.
  methods:
    database
    insert_record
    get_record
    delete_record
  */
  static Future<db.Database> getDatabase() async {
    final dbPath = await db.getDatabasesPath();
    db.Database database = await db.openDatabase(
      path.join(dbPath, "eshop.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE users(localId INTEGER PRIMARY KEY,serverId Text, username TEXT, email TEXT, password TEXT)");
      },
      version: 1,
    );

    return database;
  }

  static Future<int> insertRecord({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    /*
    This static method gets table name and data and insert them
    into database. After inserting, it will return the id of the
    inserted data.

    args:
      table
      data
    */
    final db.Database database = await getDatabase();
    int userId = await database.insert(
      table,
      data,
      conflictAlgorithm: db.ConflictAlgorithm.replace,
    );
    return userId;
  }

  static Future<List<Map<String, dynamic>>> getRecord(String table) async {
    /*
    This method gets a table name and return all data from that
    table.

    args:
      table
    */
    final db.Database database = await getDatabase();
    final records = await database.query(table);
    return records;
  }

  static Future<Map<String, dynamic>> getUser(
      String table, String userId) async {
    /*
    This method gets a table name and userId and return the a user that
    matches.
    
    args:
      table
      userId
    */
    final db.Database database = await getDatabase();
    final user =
        await database.query(table, where: "id = ?", whereArgs: [userId]);
    return user.first;
  }

  static Future<int> deleteRecord(String table, int id) async {
    /*
    This method is for removing a record from database. It gets table name
    and id, then remove the record with that id.

    args:
      table
      id
    */
    final database = await getDatabase();
    int result =
        await database.delete(table, where: "localId = ?", whereArgs: [id]);
    return result;
  }
}
