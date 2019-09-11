class WordJson {
  int id;
  String word;
  String definition;

  WordJson({ this.id, this.word, this.definition });

  factory WordJson.fromJson(Map<String, dynamic> parsedJson) {
    return WordJson(
      id: parsedJson["id"],
      word: parsedJson["word"],
      definition: parsedJson["definition"]
    );
  }


}