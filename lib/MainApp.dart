import 'package:flutter/material.dart';
import 'WordListController.dart';
import 'WordCardController.dart';
import 'Networking/NetworkCalls.dart';
import 'Model/WordJson.dart';
import 'Utils/database_helpers.dart';
import 'dart:convert';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {

  MainApp();
  @override
  _MainAppState createState() => _MainAppState();
}


class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    super.initState();
    _getWords();

  }

  DatabaseHelper helper = DatabaseHelper.instance;
  int index = 0;
  var pages = [
    WordCardController(),
    WordListController()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: pages[index]),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.today),
                  title: Text("Word Of The Day"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text("Word List"),
                ),
              ],
              currentIndex: index,
              type: BottomNavigationBarType.fixed,
              onTap: (newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
            )
        ),
      ),
    );
  }



  static List<WordJson> parseWords(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<WordJson>((json) => WordJson.fromJson(json)).toList();
  }

  _saveWordToDb(WordJson wordJson) async {
    Word word = Word();
    word.word = wordJson.word;
    word.definition = wordJson.definition;
    await helper.insert(word);
    print("word saved: $word");
  }

  _getWords() {
    NetworkCalls.getWords().then((response) {
      setState(() {
        List<WordJson> wordsJson = parseWords(response.body);
        helper.deleteAll();
        for (WordJson word in wordsJson) {
          _saveWordToDb(word);
        }
      });
    });
  }

//  _pickWordOfDay(List<WordJson> wordsList) {
//    final _random = new Random();
//    int randomNum = 1 + _random.nextInt(wordsList.length - 1);
//    return wordsList[randomNum];
//  }
}




