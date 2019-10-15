import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Words extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 2, max: 20)();
  TextColumn get definition => text().withLength(min: 2, max: 200)();
  BoolColumn get selected => boolean().withDefault(Constant(false))();
//  ListColumn get selected => integer().nullable()();
  TextColumn get synonyms => text().withLength(min: 2, max: 200)();
  TextColumn get usage => text().withLength(min: 2, max: 200)();
  }

  @UseMoor(tables: [Words])
  class MyDatabase extends _$MyDatabase {

  MyDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db1.sqlite'));

  @override
  int get schemaVersion => 4;

  Future<List<Word>> getAllWords() => select(words).get();

  Stream<List<Word>> watchAllWords() => select(words).watch();

  Future insertWord(Word word) => into(words).insert(word);

  Future updateWord(Word word) => update(words).replace(word);

}