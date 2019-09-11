import 'package:flutter/material.dart';
import 'Model/WordJson.dart';
import 'Networking/NetworkCalls.dart';
import 'dart:convert';
import 'Utils/database_helpers.dart';

class WordListController extends StatefulWidget {
  WordListController({ Key key }) : super(key: key);
  @override
  _WordListControllerState createState() => _WordListControllerState();
}

class _WordListControllerState extends State<WordListController> {

  DatabaseHelper helper = DatabaseHelper.instance;
  List<WordJson> wordsJson;
  List<Word> words;

  _readFromDb() async {

    setState(() async {
      words = await helper.queryAllWords();
    });
  }

  initState() {
    super.initState();
//    _getWords();
    _readFromDb();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {

    return Scaffold(
        body: Container(
            child:
            FutureBuilder<List<Word>>(
                future: helper.queryAllWords(),
                builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: words.length,
                        itemBuilder: (BuildContext context, int index) {
                          Word item = snapshot.data[index];
                          return ListTile(
                            title: Text(item.word),

                          );
                        }
                    );
                  } else {
                    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
                  }
                }
            )
        )
    );
  }
}