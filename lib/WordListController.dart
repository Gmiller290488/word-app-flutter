import 'package:flutter/material.dart';
import 'Utils/WordJson.dart';
import 'Utils/database_helpers.dart';

class WordListController extends StatefulWidget {
  WordListController({ Key key }) : super(key: key);

  @override
  _WordListControllerState createState() => _WordListControllerState();
}

class _WordListControllerState extends State<WordListController> {
  DatabaseHelper helper = DatabaseHelper.instance;
  List<WordJson> wordsJson;
  List<WordJson> words;

  _readFromDb() async {
    if (words == null) {
      List<WordJson> dbWords = await helper.queryAllWords();
      setState(() {
        words = dbWords;
        PageStorage.of(context).writeState(context, words,
          identifier: ValueKey("words"),
        );
      });
    }
  }

  initState() {
    words = PageStorage.of(context).readState(
      context,
      identifier: ValueKey(
        "words"
      ),
    );
    _readFromDb();
    super.initState();
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
                  return ListTile(
                      title: Text(words[index].word));
                })
        )
    );
  }
}