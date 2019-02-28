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

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "WaveDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE waves ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "code TEXT,"
          "type TEXT,"
          "status TEXT,"
          "text TEXT"
          ")");

      await db.execute("CREATE TABLE files ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "wave_id INTEGER,"
          "url TEXT,"
          "FOREIGN KEY (wave_id) REFERENCES waves(id)"
          ")");
    });
  }

  void newTextWave(Wave wave) async {
    final db = await database;
    if (wave.type == "text" && wave.files == null) {
      await db.rawInsert(
          "INSERT INTO waves (code,type,text)" +
              " VALUES (${wave.code},${wave.type},${wave.text})");
    } else {
      int id = await db.rawInsert(
          "INSERT INTO waves (code,type)" +
              " VALUES (${wave.code},${wave.type})");

      String fileQuery = "INSERT INTO files (wave_id,url) VALUES";
      for (int i = 0; i < wave.files.length; i++) {
        String url = wave.files[i];
        fileQuery += " ($id,$url)";
        if (i < wave.files.length - 1) {
          fileQuery += ",";
        }
      }

      await db.rawInsert(fileQuery);
    }
  }
}
