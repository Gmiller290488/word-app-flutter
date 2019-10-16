import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utils/database_helpers.dart';
import 'package:word_app_fl/Utils/database.dart';
import 'Networking/NetworkCalls.dart';
import 'package:word_app_fl/Blocs/wordList_bloc.dart';

class WordCardController extends StatefulWidget {

  final Word wordOfTheDay;
  final int id;
  WordCardController({ Key key, @required this.wordOfTheDay, @required this.id }) : super(key: key);

  @override
  _WordCardControllerState createState() => _WordCardControllerState();
}

class _WordCardControllerState extends State<WordCardController> {


  DatabaseHelper helper = DatabaseHelper.instance;

//  bool _isWordAdded = true;

//  @override
//  void initState() {
//    _isWordAdded = widget.wordOfTheDay.selected;
////    if (widget.wordOfTheDay.selected == null) {
////      _isWordAdded = false;
////    } else {
////      if (widget.wordOfTheDay.selected.contains(widget.id)) {
////        _isWordAdded = true;
////      } else {
////        _isWordAdded = false;
////      }
////    }
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<MyDatabase>(context);
    return StreamBuilder(
        stream: database.watchOneWord(widget.wordOfTheDay.id),
        builder: (context, AsyncSnapshot<Word> snapshot) {
          if (snapshot.hasData) {
            return

              Container(
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
                                          color: Colors.blueAccent.withOpacity(
                                              0.6),
                                          child:
                                          Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                Text("WORD OF THE DAY",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight
                                                            .bold
                                                    ))
                                              ]
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(widget.wordOfTheDay.word,
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
                                                      text: widget.wordOfTheDay
                                                          .definition,
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
                                                      text: widget.wordOfTheDay
                                                          .usage,
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
                                                              color: Colors
                                                                  .white70
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: "${widget
                                                              .wordOfTheDay
                                                              .synonyms}",
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors
                                                                  .white70
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
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
                                                  value: snapshot.data.selected,
                                                  onChanged: (value) {
                                                    database.updateWord(
                                                        snapshot.data
                                                            .copyWith(
                                                            selected: value));
                                                  }

                                              )
                                            ]

                                        )

                            )
                              ]
                            )
                              )
                          ]
                      )
                  )
              )
          )
          )
          );
          }
          return CircularProgressIndicator();
        });
  }
}

