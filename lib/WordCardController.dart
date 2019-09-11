import 'package:flutter/material.dart';
import 'Utils/database_helpers.dart';
import 'dart:math';

class WordCardController extends StatefulWidget {

  @override
  _WordCardControllerState createState() => _WordCardControllerState();
}

class _WordCardControllerState extends State<WordCardController> {

  DatabaseHelper helper = DatabaseHelper.instance;
  bool _isWordAdded;
  Word wordOfTheDay;

  @override
  void initState() {
    super.initState();
    _isWordAdded = false;
    _fetchRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child:
                ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10)),
                    child: (wordOfTheDay != null) ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(12),
                            color: Colors.blueAccent.withOpacity(0.6),
                            child:
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("WORD OF THE DAY",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold
                                      ))
                                ]
                            ),
                          ),
                          ListTile(
//                            title: Text("Bulwark",
                            title: Text(wordOfTheDay.word,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                )
                            ),
                          ),
                          ListTile(
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
                                    TextSpan(text: wordOfTheDay.definition,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white70
                                        )
                                    ),
                                  ],
                                ),
                              )
                          ),
//                          Spacer(),
//                          ListTile(
//                              title: RichText(
//                                text: TextSpan(
//                                  text: "Usage: ",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ),
//                                  children: <TextSpan>[
//                                    TextSpan(
//                                        text: '\nSyracuse was for fifty years, not only, as of old, the bulwark of Europe, but the bulwark of Christendom.',
//                                        style: TextStyle(
//                                            fontSize: 20.0,
//                                            color: Colors.white70
//                                        )
//                                    ),
//                                  ],
//                                ),
//                              )
//                          ),
//                          Spacer(),
//                          ListTile(
//                              title: RichText(
//                                text: TextSpan(
//                                  text: "Synonyms: ",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ),
//                                  children: <TextSpan>[
//                                    TextSpan(
//                                        text: '\nwall, rampart, fortification, parapet, stockade, palisade, barricade, embankment, earthwork',
//                                        style: TextStyle(
//                                            fontSize: 20.0,
//                                            color: Colors.white70
//                                        )
//                                    ),
//                                  ],
//                                ),
//                              )
//                          ),
                          Spacer(),
                          ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              child:
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(12),
                                      color: Colors.grey.withOpacity(0.6),
                                      child:
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text("ADD TO YOUR WORD LIST?"),
                                            Switch(
                                                value: _isWordAdded,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isWordAdded = value;
                                                  });
                                                }
                                            )
                                          ]
                                      )
                                  ),
                                ],
                              )
                          )
                        ]
                    ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)))
                )
            )
        )
    );
  }

  _fetchRandomWord() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Word> dbWords = await helper.queryAllWords();
    final _random = new Random();
    int randomNum = 1 + _random.nextInt(dbWords.length - 1);
    print(dbWords[randomNum]);
    setState(() {
      wordOfTheDay = dbWords[randomNum];
    });

  }
}


