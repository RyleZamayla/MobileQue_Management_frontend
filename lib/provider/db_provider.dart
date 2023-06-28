import 'dart:async';
import 'package:mobilequemanagement_frontend/model/login_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBProvider {
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
        "CREATE TABLE user(accessToken VARCHAR(255) NOT NULL, user_id VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, "
            "email VARCHAR(255) NOT NULL, position VARCHAR(255) NOT NULL, queueLimit INT NOT NULL, "
            " PRIMARY KEY (user_id));");
  }

  Future<User>insertUser(User user) async {
    var dbClient = await database;
    await dbClient?.insert('user', user.toJson());
    return user;
  }

}