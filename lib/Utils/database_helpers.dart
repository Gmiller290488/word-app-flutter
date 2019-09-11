import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnDef = 'definition';

class Word {

  int id;
  String word;
  String definition;

  Word();

  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    definition = map[columnDef];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnWord: word,
      columnId: id,
      columnDef: definition
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {

  static final _databaseName = 'Wordsdatabase.db';
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
          $columnDef TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    return id;
  }

  deleteAll() async {
    final db = await database;
    db.delete("words");
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
      columns: [columnId, columnWord, columnDef],
      where: '$columnId= ?',
      whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> queryAllWords() async {
    final db = await database;
    var response = await db.query("words");
    List<Word> list = response.map((c) => Word.fromMap(c)).toList();
    return list;
  }
}