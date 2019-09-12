import 'package:flutter/gestures.dart';
import 'dart:convert';

class WordJson {
  int id;
  String word;
  String definition;
  int selected;

  final String columnId = '_id';
  final String columnWord = 'word';
  final String columnDef = 'definition';
  final String columnSelected = 'selected';

  WordJson({ this.id, this.word, this.definition, this.selected});

  factory WordJson.fromJson(Map<String, dynamic> parsedJson) {
    return WordJson(
      id: parsedJson["id"],
      word: parsedJson["word"],
      definition: parsedJson["definition"],
      selected: parsedJson["selected"]
    );
  }

  WordJson.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    definition = map[columnDef];
    selected = map[columnSelected];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnWord: word,
      columnId: id,
      columnDef: definition,
      columnSelected: selected
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

}