class Word {
  int id;
  String word;
  String definition;
  bool selected;
  String synonyms;
  String usage;
  bool expanded;

  final String columnId = '_id';
  final String columnWord = 'word';
  final String columnDef = 'definition';
  final String columnSelected = 'selected';
  final String columnSynonyms = 'synonyms';
  final String columnUsage = 'usage';

  Word({ this.id, this.word, this.definition, this.selected, this.synonyms, this.usage });

  factory Word.fromJson(Map<String, dynamic> parsedJson) {
    return Word(
        id: parsedJson["id"],
        word: parsedJson["word"],
        definition: parsedJson["definition"],
        selected: parsedJson["selected"],
        synonyms: parsedJson["synonyms"],
        usage: parsedJson["usage"]
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "definition": definition,
        "selected": selected,
        "synonyms": synonyms,
        "usage": usage
  };

  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    definition = map[columnDef];
    selected = map[columnSelected];
    synonyms = map[columnSynonyms];
    usage = map[columnUsage];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnWord: word,
      columnId: id,
      columnDef: definition,
      columnSelected: selected,
      columnSynonyms: synonyms,
      columnUsage: usage
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

}