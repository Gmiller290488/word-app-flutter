// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String word;
  final String definition;
  final bool selected;
  final String synonyms;
  final String usage;
  Word(
      {@required this.id,
      @required this.word,
      @required this.definition,
      @required this.selected,
      @required this.synonyms,
      @required this.usage});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Word(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      word: stringType.mapFromDatabaseResponse(data['${effectivePrefix}word']),
      definition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}definition']),
      selected:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}selected']),
      synonyms: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}synonyms']),
      usage:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}usage']),
    );
  }
  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      definition: serializer.fromJson<String>(json['definition']),
      selected: serializer.fromJson<bool>(json['selected']),
      synonyms: serializer.fromJson<String>(json['synonyms']),
      usage: serializer.fromJson<String>(json['usage']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'definition': serializer.toJson<String>(definition),
      'selected': serializer.toJson<bool>(selected),
      'synonyms': serializer.toJson<String>(synonyms),
      'usage': serializer.toJson<String>(usage),
    };
  }

  @override
  WordsCompanion createCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      word: word == null && nullToAbsent ? const Value.absent() : Value(word),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
      selected: selected == null && nullToAbsent
          ? const Value.absent()
          : Value(selected),
      synonyms: synonyms == null && nullToAbsent
          ? const Value.absent()
          : Value(synonyms),
      usage:
          usage == null && nullToAbsent ? const Value.absent() : Value(usage),
    );
  }

  Word copyWith(
          {int id,
          String word,
          String definition,
          bool selected,
          String synonyms,
          String usage}) =>
      Word(
        id: id ?? this.id,
        word: word ?? this.word,
        definition: definition ?? this.definition,
        selected: selected ?? this.selected,
        synonyms: synonyms ?? this.synonyms,
        usage: usage ?? this.usage,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition, ')
          ..write('selected: $selected, ')
          ..write('synonyms: $synonyms, ')
          ..write('usage: $usage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          word.hashCode,
          $mrjc(
              definition.hashCode,
              $mrjc(selected.hashCode,
                  $mrjc(synonyms.hashCode, usage.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.word == this.word &&
          other.definition == this.definition &&
          other.selected == this.selected &&
          other.synonyms == this.synonyms &&
          other.usage == this.usage);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> definition;
  final Value<bool> selected;
  final Value<String> synonyms;
  final Value<String> usage;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
    this.selected = const Value.absent(),
    this.synonyms = const Value.absent(),
    this.usage = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    @required String word,
    @required String definition,
    this.selected = const Value.absent(),
    @required String synonyms,
    @required String usage,
  })  : word = Value(word),
        definition = Value(definition),
        synonyms = Value(synonyms),
        usage = Value(usage);
  WordsCompanion copyWith(
      {Value<int> id,
      Value<String> word,
      Value<String> definition,
      Value<bool> selected,
      Value<String> synonyms,
      Value<String> usage}) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      definition: definition ?? this.definition,
      selected: selected ?? this.selected,
      synonyms: synonyms ?? this.synonyms,
      usage: usage ?? this.usage,
    );
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _wordMeta = const VerificationMeta('word');
  GeneratedTextColumn _word;
  @override
  GeneratedTextColumn get word => _word ??= _constructWord();
  GeneratedTextColumn _constructWord() {
    return GeneratedTextColumn('word', $tableName, false,
        minTextLength: 2, maxTextLength: 20);
  }

  final VerificationMeta _definitionMeta = const VerificationMeta('definition');
  GeneratedTextColumn _definition;
  @override
  GeneratedTextColumn get definition => _definition ??= _constructDefinition();
  GeneratedTextColumn _constructDefinition() {
    return GeneratedTextColumn('definition', $tableName, false,
        minTextLength: 2, maxTextLength: 200);
  }

  final VerificationMeta _selectedMeta = const VerificationMeta('selected');
  GeneratedBoolColumn _selected;
  @override
  GeneratedBoolColumn get selected => _selected ??= _constructSelected();
  GeneratedBoolColumn _constructSelected() {
    return GeneratedBoolColumn('selected', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _synonymsMeta = const VerificationMeta('synonyms');
  GeneratedTextColumn _synonyms;
  @override
  GeneratedTextColumn get synonyms => _synonyms ??= _constructSynonyms();
  GeneratedTextColumn _constructSynonyms() {
    return GeneratedTextColumn('synonyms', $tableName, false,
        minTextLength: 2, maxTextLength: 200);
  }

  final VerificationMeta _usageMeta = const VerificationMeta('usage');
  GeneratedTextColumn _usage;
  @override
  GeneratedTextColumn get usage => _usage ??= _constructUsage();
  GeneratedTextColumn _constructUsage() {
    return GeneratedTextColumn('usage', $tableName, false,
        minTextLength: 2, maxTextLength: 200);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, word, definition, selected, synonyms, usage];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(WordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.word.present) {
      context.handle(
          _wordMeta, word.isAcceptableValue(d.word.value, _wordMeta));
    } else if (word.isRequired && isInserting) {
      context.missing(_wordMeta);
    }
    if (d.definition.present) {
      context.handle(_definitionMeta,
          definition.isAcceptableValue(d.definition.value, _definitionMeta));
    } else if (definition.isRequired && isInserting) {
      context.missing(_definitionMeta);
    }
    if (d.selected.present) {
      context.handle(_selectedMeta,
          selected.isAcceptableValue(d.selected.value, _selectedMeta));
    } else if (selected.isRequired && isInserting) {
      context.missing(_selectedMeta);
    }
    if (d.synonyms.present) {
      context.handle(_synonymsMeta,
          synonyms.isAcceptableValue(d.synonyms.value, _synonymsMeta));
    } else if (synonyms.isRequired && isInserting) {
      context.missing(_synonymsMeta);
    }
    if (d.usage.present) {
      context.handle(
          _usageMeta, usage.isAcceptableValue(d.usage.value, _usageMeta));
    } else if (usage.isRequired && isInserting) {
      context.missing(_usageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.word.present) {
      map['word'] = Variable<String, StringType>(d.word.value);
    }
    if (d.definition.present) {
      map['definition'] = Variable<String, StringType>(d.definition.value);
    }
    if (d.selected.present) {
      map['selected'] = Variable<bool, BoolType>(d.selected.value);
    }
    if (d.synonyms.present) {
      map['synonyms'] = Variable<String, StringType>(d.synonyms.value);
    }
    if (d.usage.present) {
      map['usage'] = Variable<String, StringType>(d.usage.value);
    }
    return map;
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  @override
  List<TableInfo> get allTables => [words];
}
