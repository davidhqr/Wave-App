import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:wave/db/wave.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "WaveDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE waves ("
          "id INTEGER PRIMARY KEY,"
          "code TEXT,"
          "type TEXT,"
          "text TEXT"
          ")");

      await db.execute("CREATE TABLE files ("
          "id INTEGER PRIMARY KEY,"
          "wave_id INTEGER,"
          "url TEXT,"
          "FOREIGN KEY (wave_id) REFERENCES waves(id)"
          ")");
    });
  }

  newTextWave(Wave wave) async {
    final db = await database;
    var res;
    if (wave.type == "text" && wave.files == null) {
      res = await db.rawInsert(
          "INSERT Into Wave (id,code,type,text)"
              " VALUES (${wave.id},${wave.code},${wave.type},${wave.text})");
    } else {
      res = await db.rawInsert(
          "INSERT Into Wave (id,code,type,text)"
              " VALUES (${wave.id},${wave.code},${wave.type},${wave.text})");
    }
    return res;
  }
}
