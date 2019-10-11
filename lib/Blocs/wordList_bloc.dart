import 'dart:async';

import 'package:word_app_fl/Blocs/bloc_provider.dart';
import 'package:word_app_fl/Utils/database_helpers.dart';
import 'package:word_app_fl/Models/word.dart';
import 'package:rxdart/rxdart.dart';

class WordListBloc {

  DatabaseHelper helper = DatabaseHelper.instance;

  final _wordsController = StreamController<List<Word>>.broadcast();

  StreamSink<List<Word>> get _inWords => _wordsController.sink;

  Stream<List<Word>> get words => _wordsController.stream;

  final _addWordController = StreamController<Word>.broadcast();
  StreamSink<Word> get inAddWord => _addWordController.sink;
  WordListBloc() {
    getWords();

    _addWordController.stream.listen(_handleUpdateWord);
  }


  dispose() {
    _wordsController.close();
    _addWordController.close();
  }

  getWords( {int id} ) async {
    List<Word> words = await helper.queryAllWords();
    print(words);
    words.removeWhere((Word word) => !word.selected.contains(1));
    print(words);
    _inWords.add(words);
  }

  _handleUpdateWord(Word word) async {
    await helper.updateWord(word);

    getWords();
  }
}