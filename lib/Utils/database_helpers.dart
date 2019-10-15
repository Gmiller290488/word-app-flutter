import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/word.dart';

final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnDef = 'definition';
final String columnSelected = 'selected';
final String columnSynonyms = 'synonyms';
final String columnUsage = 'usage';

class DatabaseHelper {

  static final _databaseName = 'Wordsdatabase1.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableWords (
          $columnId INTEGER PRIMARY KEY,
          $columnWord TEXT NOT NULL,
          $columnDef TEXT NOT NULL,
          $columnSelected INTEGER NOT NULL,
          $columnUsage TEXT NOT NULL,
          $columnSynonyms TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    print(word.toMap());
    return id;
  }

  deleteAll() async {
    final db = await database;
    db.delete("words");
  }

  Future<Word> queryWordById(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [columnId, columnWord, columnDef, columnSynonyms, columnUsage, columnSelected],
        where: '$columnId= ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<Word> queryWordByWord(String word) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [columnId, columnWord, columnDef, columnSynonyms, columnUsage, columnSelected],
        where: '$columnWord= ?',
        whereArgs: [word]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> queryAllWords() async {
    final db = await database;
    var response = await db.query("words");
    List<Word> list = response.map((c) => Word.fromMap(c)).toList();
    if (list.length > 0) {
      return list;
    }
    return null;
  }

  Future<List<Word>> queryAllSelectedWords(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM words WHERE selected = ?", [2]);
    List<Word> list = res.map((c) => Word.fromMap(c)).toList();
    if (res.length > 0) {
      return list;
    }
    return null;
  }
//
//  Future<List<Word>> queryAllUnselectedWords() async {
//    final db = await database;
//    List<Map> maps = await db.query(tableWords,
//        columns: [columnId, columnWord, columnDef, columnSynonyms, columnUsage, columnSelected],
//        orderBy: "word",
//        where: '$columnSelected=false',
//        whereArgs: ["true"]);
//    List<Word> list = maps.map((c) => Word.fromMap(c)).toList();
//    if (maps.length > 0) {
//      return list;
//    }
//    return null;
//  }

  Future<int> updateWord(Word word) async {
    final db = await database;
    int id;
    try {
      id = await db.update("words",
          word.toMap(),
          where: "_id = ?",
          whereArgs: [word.id]);
    } catch (error) {
      print(error);
    }
    return id;
  }
}