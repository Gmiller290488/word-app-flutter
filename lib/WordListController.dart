import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Utils/word.dart';
import 'Utils/database_helpers.dart';
import 'WordScreen.dart';

class WordListController extends StatefulWidget {

  final List<Word> words;
  WordListController({ Key key, @required this.words }) : super(key: key);

  @override
  _WordListControllerState createState() => _WordListControllerState();
}

class _WordListControllerState extends State<WordListController> {

  List<Word> words;
  _WordListControllerState({ this.words });

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Word> wordsJson;


  _readFromDb() async {
        List<Word> dbWords = await helper.queryAllSelectedWords();

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
                words == null ?
                Center(
                    child:
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child:
                            Text("No words were found...\n  You can start by adding Today's Word of the Day!",
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 22),)
                        ),
                ) :
                ListView.builder(itemCount: words.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                          onExpansionChanged: (bool expanding) => setState(() {
                            words[index].expanded = expanding;
                          }),
                          initiallyExpanded: words[index].expanded ?? false,
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
                                  fontWeight:
                                  words[index].expanded ?? false ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.white
                                ),
                              ),
                            ),

                            // Change header (which is a Container widget in this case) background colour here.
                            color: Colors.transparent,
                          ),
                          trailing: words[index].expanded ?? false ? Icon(
                              Icons.arrow_drop_up
                          ) :
                          Icon(
                              Icons.arrow_drop_down
                          ),
                          children:<Widget>[
                            ListTile(
                                trailing: Icon(Icons.arrow_forward_ios),
                                title: RichText(
                                  text: TextSpan(
                                    text: "Definition: ",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    children: <TextSpan>[
//                                    TextSpan(text: '\nA defensive wall',
                                      TextSpan(text: '\n',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white70
                                          )
                                      ),
                                      TextSpan(text: words[index].definition,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white70
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              onTap: () {
                                  Navigator.of(context).push (
                                    CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => WordScreen(word: words[index])),
                                  );
                              }
                            ),
                          ]
                      );
                    }
                )
            )
        )
    );
  }
}
