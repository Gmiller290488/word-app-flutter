import 'package:flutter/material.dart';
import 'Model/word.dart';
import 'Networking/NetworkCalls.dart';
import 'dart:convert';

class WordListController extends StatefulWidget {
  WordListController({ Key key }) : super(key: key);
  @override
  _WordListControllerState createState() => _WordListControllerState();
}

class _WordListControllerState extends State<WordListController> {

  List<Word> words;

  _getWords() {
    NetworkCalls.getWords().then((response) {
      setState(() {
        words = parseWords(response.body);
      });
    });
  }

  static List<Word> parseWords(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Word>((json) => Word.fromJson(json)).toList();
  }

  initState() {
    super.initState();
    _getWords();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {

    return Scaffold(
        body: Container(
            child:
            words == null ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))) :
            ListView.builder(itemCount: words.length,
                itemBuilder: (context, index) {
                  return _buildItem(words[index]);
                })
        )
    );
  }
}

Widget _buildItem(Word word) {
  return new Text("${word.word} - ${word.definition}");
}