class WordJson {
  int id;
  String word;
  String definition;

  final String columnId = '_id';
  final String columnWord = 'word';
  final String columnDef = 'definition';

  WordJson({ this.id, this.word, this.definition });

  factory WordJson.fromJson(Map<String, dynamic> parsedJson) {
    return WordJson(
      id: parsedJson["id"],
      word: parsedJson["word"],
      definition: parsedJson["definition"]
    );
  }

  WordJson.fromMap(Map<String, dynamic> map) {
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