import 'package:flutter/material.dart';
import 'WordListController.dart';
import 'WordCardController.dart';
import 'Networking/NetworkCalls.dart';
import 'Utils/WordJson.dart';
import 'Utils/database_helpers.dart';
import 'dart:convert';
import 'Utils/shared_prefs_helpers.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {

  MainApp();
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final Key keyTwo = PageStorageKey('WordListController');
  final Key keyOne = PageStorageKey('WordCardController');

  int currentTab = 0;

  WordCardController one;
  WordListController two;
  List<Widget> pages;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage;

  @override
  void initState() {
    one = WordCardController(
      key: keyOne,
    );
    two = WordListController(
//      key: keyTwo,
    );
    pages = [one, two];

    currentPage = one;

    _getWords();
    SharedPrefsHelper.updateDateLastOpened();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.black,
            body: PageStorage(
              child: currentPage,
              bucket: bucket,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentTab,
                onTap: (int index) {
                  setState(() {
                    currentTab = index;
                    currentPage = pages[index];
                  });
                },
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

              type: BottomNavigationBarType.fixed,
            )
        ),
      ),
    );
  }

  static List<WordJson> parseWords(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    var list = parsed.map<WordJson>((json) => WordJson.fromJson(json)).toList();
    print(list);
    return list;
  }

  _saveWordToDb(WordJson wordJson) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.insert(wordJson);
  }

  _getWords() async {

    NetworkCalls.getWords().then((response) {
        List<WordJson> wordsJson = parseWords(response.body);
        for (WordJson word in wordsJson) {
          print(word);
            _saveWordToDb(word);
          }
    });
  }
}




