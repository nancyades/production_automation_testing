import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PatDataBase {

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'patdatabase.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY,"
              "user_id TEXT NOT NULL,"
              "emp_id TEXT NOT NULL,"
              "name TEXT NOT NULL,"
              "password TEXT NOT NULL,"
              "avatar TEXT NOT NULL,"
              "email_id TEXT NOT NULL,"
              "phoneno TEXT NOT NULL,"
              "role TEXT NOT NULL,"
              "created_by TEXT NOT NULL,"
              "updated_by TEXT NOT NULL,"
              "updated_date TEXT NOT NULL,"
              "flag TEXT NOT NULL,)",
        );
        /*await db.execute(
          "CREATE TABLE schedule(id INTEGER PRIMARY KEY , scheduleno TEXT NOT NULL,packets TEXT NOT NULL)",
        );*/
      },
    );
  }

}