import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_app_fl/Utils/database.dart';
import 'package:word_app_fl/Utils/database_helpers.dart';
import 'package:word_app_fl/WordScreen.dart';
import 'package:word_app_fl/Blocs/bloc_provider.dart';
import 'package:word_app_fl/Blocs/wordList_bloc.dart';
import 'package:word_app_fl/Utils/shared_prefs_helpers.dart';

//class WordListController extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "Words",
//      theme: ThemeData.dark(),
//      home: BlocProvider(
//        bloc: WordListBloc(),
//        child: WordListPage(title: "words"),
//      )
//    );
//  }
//
//}

//class WordListPage extends StatefulWidget {
//
//  WordListPage({ @required this.title });
//
//  final String title;
//
//  @override
//  _WordListPageState createState() => _WordListPageState();
//}


class WordListController extends StatelessWidget {
  final WordListBloc wordListBloc = WordListBloc();
//  int id;

//  @override
//  void initState() {
//    super.initState();
//    if (id == null) {
//      getId();
//    }
//    _wordsListBloc = BlocProvider.of<WordListBloc>(context);
//  }
//
//  getId() async {
//    id = await SharedPrefsHelper.getId();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<List<Word>>(
                  stream: wordListBloc.words,
                  builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
                    if (snapshot.hasData) {
                      print("has data");
                      List<Word> words = snapshot.data;

//                      words.removeWhere((Word word) => !word.selected.contains(1));

                      if (words.length == 0) {
                        return Center(
                            child:
                            Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child:
                                Text("No words were found...\n  You can start by adding Today's Word of the Day!",
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 22),)
                            )
                        );
                      }

                      return ListView.builder(itemCount: words.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
//                                onExpansionChanged: (bool expanding) =>
//                                    setState(() {
//                                      words[index].expanded = expanding;
//                                    }),
//                                initiallyExpanded: words[index].expanded ??
//                                    false,
                                initiallyExpanded: false,
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
//                                          fontWeight:
//                                          words[index].expanded ?? false
//                                              ? FontWeight
//                                              .bold
//                                              : FontWeight.normal,
                                      fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),

                                  // Change header (which is a Container widget in this case) background colour here.
                                  color: Colors.transparent,
                                ),
//                                trailing: words[index].expanded ?? false ? Icon(
//                                    Icons.arrow_drop_up
//                                ) :
//                                Icon(
//                                    Icons.arrow_drop_down
//                                ),
                            trailing: Icon(Icons.arrow_drop_up),
                                children: <Widget>[
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
                                            TextSpan(
                                                text: words[index].definition,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white70
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) =>
                                                  WordScreen(
                                                      word: words[index])),
                                        );
                                      }
                                  ),
                                ]
                            );
                          });
                    } else {
                      print("has no data");
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                )
              )
            ],
          )
        )
      );
  }

}


//class WordListController extends StatefulWidget {
//
//  final List<Word> words;
//  final int id;
//  WordListController({ Key key, @required this.words, @required this.id }) : super(key: key);
//
//  @override
//  _WordListControllerState createState() => _WordListControllerState();
//}
//
//class _WordListControllerState extends State<WordListController> {
//
//  List<Word> words;
//  _WordListControllerState({ this.words });
//
//  DatabaseHelper helper = DatabaseHelper.instance;
//  List<Word> wordsJson;
//
//
//  _readFromDb() async {
//        List<Word> dbAllWords = await helper.queryAllWords();
//        List<Word> dbWords = [];
//        for (Word word in dbAllWords) {
//          if (word.selected != null) {
//            if (word.selected.contains(widget.id)) {
//              dbWords.add(word);
//            }
//          }
//        }
//
//        if (dbWords != null) {
//          if (words == null || (words.length != dbWords.length)) {
//            setState(() {
//              words = dbWords;
//              PageStorage.of(context).writeState(context, words,
//                identifier: ValueKey("words"),
//              );
//            });
//          }
//        } else {
//          setState(() {
//            words = null;
//          });
//        }
//  }
//
//  initState() {
//    words = PageStorage.of(context).readState(
//      context,
//      identifier: ValueKey(
//          "words"
//      ),
//    );
//    _readFromDb();
//    super.initState();
//  }
//
//  dispose() {
//    super.dispose();
//  }
//
//  @override
//  build(context) {
//    return Scaffold(
//        body: Container(
//            child:
//            SafeArea(
//                child:
//                words == null ?
//                Center(
//                    child:
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
//                          child:
//                            Text("No words were found...\n  You can start by adding Today's Word of the Day!",
//                            textAlign: TextAlign.center, style: TextStyle(fontSize: 22),)
//                        ),
//                ) :
//
//                ListView.builder(itemCount: words.length,
//                    itemBuilder: (context, index) {
//                      return ExpansionTile(
//                          onExpansionChanged: (bool expanding) => setState(() {
//                            words[index].expanded = expanding;
//                          }),
//                          initiallyExpanded: words[index].expanded ?? false,
//                          key: PageStorageKey('${words[index].id}'),
//                          title:
//                          Container(
//                            child:
//                            Align(
//                              alignment: Alignment.centerLeft,
//                              child: Text(
//                                words[index].word,
//                                style: TextStyle(
//                                  fontSize: 24.0,
//                                  fontWeight:
//                                  words[index].expanded ?? false ? FontWeight.bold
//                                      : FontWeight.normal,
//                                  color: Colors.white
//                                ),
//                              ),
//                            ),
//
//                            // Change header (which is a Container widget in this case) background colour here.
//                            color: Colors.transparent,
//                          ),
//                          trailing: words[index].expanded ?? false ? Icon(
//                              Icons.arrow_drop_up
//                          ) :
//                          Icon(
//                              Icons.arrow_drop_down
//                          ),
//                          children:<Widget>[
//                            ListTile(
//                                trailing: Icon(Icons.arrow_forward_ios),
//                                title: RichText(
//                                  text: TextSpan(
//                                    text: "Definition: ",
//                                    style: TextStyle(
//                                        color: Colors.white
//                                    ),
//                                    children: <TextSpan>[
////                                    TextSpan(text: '\nA defensive wall',
//                                      TextSpan(text: '\n',
//                                          style: TextStyle(
//                                              fontSize: 20.0,
//                                              color: Colors.white70
//                                          )
//                                      ),
//                                      TextSpan(text: words[index].definition,
//                                          style: TextStyle(
//                                              fontSize: 20.0,
//                                              color: Colors.white70
//                                          )
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              onTap: () {
//                                  Navigator.of(context).push (
//                                    CupertinoPageRoute(
//                                      fullscreenDialog: true,
//                                      builder: (context) => WordScreen(word: words[index])),
//                                  );
//                              }
//                            ),
//                          ]
//                      );
//                    }
//                )
//            )
//        )
//    );
//  }
//}
