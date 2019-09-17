import 'package:flutter/material.dart';
import 'Utils/word.dart';

class WordScreen extends StatelessWidget {

  final Word word;

  WordScreen({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(word.word,
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold
              )),
          backgroundColor: Colors.blueAccent.withOpacity(0.6),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
          leading: Container(),
        ),
        body: Container(
          child: SafeArea(
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Spacer(),
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
                                TextSpan(text: word.definition,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white70
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                      Spacer(),
                      ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: "Usage: ",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n${word.usage}.',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white70
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                      Spacer(),
                      ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: "Synonyms: ",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n${word.synonyms}',
//                                        'wall, rampart, fortification, parapet, stockade, palisade, barricade, embankment, earthwork',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white70
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                      Spacer(),
//                      Container(
//                        color: Colors.red,
//                        child:
//                            Padding(padding: EdgeInsets.all(14),
//                      child:
//                          MaterialButton(
//                            onPressed: _deleteWord(),
//                          child:
//                      Row(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment
//                            .center,
//                        children: <Widget>[
//
//                          Text("REMOVE FROM YOUR WORD LIST?"),
//                            ]
//                          ),
//
//                      ),
//                      ),
//                      )
                      ]
                ),
                    )
            ),
          ),
    );
  }

  _deleteWord() {
    print("delete");
  }
}