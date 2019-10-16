import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_app_fl/Utils/database.dart';
import 'package:word_app_fl/WordScreen.dart';

class WordListController extends StatefulWidget {

  WordListController({Key key}) : super(key: key);

  @override
  _WordListControllerState createState() => _WordListControllerState();
}

class _WordListControllerState extends State<WordListController> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Words",
      theme: ThemeData.dark(),
      home: _buildWordList(context),
    );
  }
}

StreamBuilder<List<Word>> _buildWordList(BuildContext context) {
  final database = Provider.of<MyDatabase>(context);
  return StreamBuilder(
      stream: database.watchAllWords(),
      builder: (context, AsyncSnapshot<List<Word>> snapshot) {

        if (snapshot.hasData) {
          print("has data");
          List<Word> words = snapshot.data;
          words.removeWhere((Word word) => word.selected == false);

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
                    onExpansionChanged: (bool expanding) {
                      database.updateWord(
                          words[index]
                              .copyWith(
                              expanded: expanding)
                      );
                    },
                    initiallyExpanded: words[index].expanded,
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
                              words[index].expanded ?? false
                                  ? FontWeight
                                  .bold
                                  : FontWeight.normal,
                              color: Colors.white
                          ),
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                    trailing: words[index].expanded ? Icon(
                        Icons.arrow_drop_up
                    ) :
                    Icon(
                        Icons.arrow_drop_down
                    ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
  );


}

