import 'package:flutter/material.dart';
import 'Model/word.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Word App'),
    );
  }
}

class API {
  static Future getWords() {
    var url = "http://localhost:8080/api/word";
    return http.get(url);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Word> words;

  _getWords() {
    API.getWords().then((response) {
      setState(() {
        words = parseWords(response.body);
      });
    });
  }

  static List<Word> parseWords(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Word>((json) => Word.fromJson(json)).toList();
  }

  initState() {
    super.initState();
    _getWords();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(

        child:
//        words == null ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))) : Text("${words.first.word} - ${words.first.definition}"))
          words == null ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))) :
          ListView.builder(itemCount: words.length,
                  itemBuilder: (context, index) {
            return _buildItem(words[index]);
    })
    );
  }
}

Widget _buildItem(Word word) {
  return new Text("${word.word} - ${word.definition}");
}
