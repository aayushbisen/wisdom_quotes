import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/// Database Definition and Operations are defined in this class.
class DatabaseHelper {
  static const _databaseName = 'MyDatabase.db';
  static const _databaseVersion = 1;

  static const table = 'my_quotes';

  static const columnId = '_id';
  static const columnQuoteKey = 'quotekey';
  static const columnName = 'author';
  static const String columnQuote = 'quote';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  /// static variable to access db from anywhere.
  static Database _database;

  /// db getter function.
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    return _database = await _initDatabase();
  }

  /// Database initialisation is done here.
  Future<Database> _initDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, _databaseName);
    return openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const String query = '''
    CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnQuoteKey TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnQuote TEXT NOT NULL
          )
    ''';
    await db.execute(query);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    return db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> rowsWithThisKey(String quoteKey) async {
    final Database db = await instance.database;
    return db.query(
      table,
      columns: [columnQuoteKey],
      where: '$columnQuoteKey = ?',
      whereArgs: [quoteKey],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final Database db = await instance.database;
    return db.query(
      table,
      orderBy: '$columnId DESC',
    );
  }

  Future<int> delete(int id) async {
    final Database db = await instance.database;
    return db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByKey(String quoteKey) async {
    final Database db = await instance.database;
    return db.delete(
      table,
      where: '$columnQuoteKey = ?',
      whereArgs: [quoteKey],
    );
  }
}
