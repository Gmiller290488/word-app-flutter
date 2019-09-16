import 'package:flutter/material.dart';
import 'Utils/word.dart';

class WordOfTheDayScreen extends StatelessWidget {

  final Word wordOfTheDay;

  WordOfTheDayScreen({ Key key, @required this.wordOfTheDay })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10)),
                      child: Column(
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
                                    Spacer(),
                                    Spacer(),
                                    Text("WORD OF THE DAY",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                        )),
                                    Spacer(),
                                    CloseButton()
                                  ]
                              ),
                            ),
                            ListTile(
                              title: Text(wordOfTheDay.word,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 40.0,
                                  )
                              ),
                            ),
                            ListTile(
                                title: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                    text: "Definition: ",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: '\n',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white70
                                          )
                                      ),
                                      TextSpan(
                                          text: wordOfTheDay.definition,
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
                                  softWrap: true,
                                  text: TextSpan(
                                    text: "Usage: ",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: '\n',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white70
                                          )
                                      ),
                                      TextSpan(
                                          text: wordOfTheDay.usage,
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
                            Wrap(
                              children: <Widget>[
                                ListTile(
                                    title:
                                    RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        text: "Synonyms:",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: '\n',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white70
                                              )
                                          ),
                                          TextSpan(
                                              text: "${wordOfTheDay.synonyms}",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white70
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                            Spacer(),
                          ]
                      ),
                    )
                )
            )
        )
    );
  }
}