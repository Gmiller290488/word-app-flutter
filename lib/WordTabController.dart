import 'package:flutter/material.dart';
import 'WordListController.dart';
import 'WordCardController.dart';
import 'Utils/word.dart';
import 'Utils/shared_prefs_helpers.dart';

class WordTabController extends StatefulWidget {
  final List<Word> dbUnselectedWords;
  final List<Word> dbSelectedWords;
  final Word wordOfTheDay;
  final int id;
  WordTabController({ Key key, @required this.dbUnselectedWords, @required this.dbSelectedWords, @required this.wordOfTheDay, @required this.id }) : super(key: key);

  @override
  _WordTabControllerState createState() => _WordTabControllerState();
}

class _WordTabControllerState extends State<WordTabController> {

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
    one = WordCardController(wordOfTheDay: widget.wordOfTheDay, id: widget.id, key: keyOne);
    two = WordListController(words: widget.dbSelectedWords, id: widget.id);
    pages = [one, two];
    currentPage = one;

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
}




