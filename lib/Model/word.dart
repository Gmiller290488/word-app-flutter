class Word {
  int id;
  String word;
  String definition;

  Word({ this.id, this.word, this.definition });

  factory Word.fromJson(Map<String, dynamic> parsedJson) {
    return Word(
      id: parsedJson["id"],
      word: parsedJson["word"],
      definition: parsedJson["definition"]
    );
  }


}