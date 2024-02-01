import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "my_notes.db");
    var dailyAppDb = await openDatabase(
      dbPath,
      version: 1,
      onCreate: createDb,
    );
    return dailyAppDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table notes(Id integer primary key, Title text,Value text,MaterialityId integer)");
  }
}
