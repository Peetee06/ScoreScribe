import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final _dbName = 'games.db';
  final _dbVersion = 1;

  final String _gameTableName = 'games';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_gameTableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        playerNames TEXT,
        rounds TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_gameTableName, row);
  }

  Future<List<Map<String, dynamic>>> query() async {
    Database db = await instance.database;
    return await db.query(_gameTableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row['id'];
    return await db
        .update(_gameTableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(_gameTableName, where: 'id = ?', whereArgs: [id]);
  }
}
