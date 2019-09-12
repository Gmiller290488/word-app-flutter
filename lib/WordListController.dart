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
  bool isExpanded = false;

  _readFromDb() async {
    List<WordJson> dbWords = await helper.queryAllSelectedWords();

    if (dbWords != null) {
      if (words == null || (words.length != dbWords.length)) {
        setState(() {
          words = dbWords;
          PageStorage.of(context).writeState(context, words,
            identifier: ValueKey("words"),
          );
        });
      }
    } else {
      setState(() {
        words = null;
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
            SafeArea(
                child:
                words == null ? Text("No words found!  You can start by adding Today's Word of the Day!") :
                ListView.builder(itemCount: words.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                          key: PageStorageKey('${words[index].id}'),
                          title:
                          Container(
                            child:
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                words[index].word,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: isExpanded
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),

                            // Change header (which is a Container widget in this case) background colour here.
                            color: Colors.transparent,
                          ),
                          trailing: isExpanded ? Icon(
                              Icons.arrow_drop_up
                          ) :
                          Icon(
                              Icons.arrow_drop_down
                          )
                      );
                    }
                )
            )
        )
    );
  }
}
