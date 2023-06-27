import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class dbProvicer {
  static Database? _database;

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'mobileQueueing.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY , name TEXT NOT NULL, email TEXT NOT NULL, position TEXT NOT NULL, queueLimit INTEGER NOT NULL);");
  }

  // Database db = await openDatabase('my_database.db', version: 1, onCreate: (db, version) {
  // // Create the table
  // db.execute('CREATE TABLE my_table (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, email TEXT)');
  // });
}