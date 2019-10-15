
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:provider/provider.dart';
import 'package:word_app_fl/Utils/database.dart';
import 'WordTabController.dart';
//import 'Models/word.dart';
import 'Utils/database_helpers.dart';
import 'Networking/NetworkCalls.dart';
import 'dart:convert';
import 'Utils/shared_prefs_helpers.dart';
import 'dart:math';
import 'WordOfTheDayScreen.dart';
import 'Models/user.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  WordTabController wordTabController;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  Word registeredWordOfTheDay;
  Word guestWordOfTheDay;
  int id;
  String token;
  static List<Word> dbSelectedWords;
  static List<Word> dbUnselectedWords;
  static List<Word> dbAllWords;
  static List<Word> wordsJson;


  @override
  void initState() {
    wordTabController = WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords, wordOfTheDay: registeredWordOfTheDay, id: id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getWords();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey.withOpacity(0.6),
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      child: Stack(

                        children: <Widget>[
                          Opacity(
                              opacity: 0.1,
                              child: GradientText("WORD APP",
                                  gradient: LinearGradient(
                                      colors: [Colors.white, Colors.white60 , Colors.white70, Colors.white60, Colors.white]),
                                  style: TextStyle(fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      fontFamily: "Montserrat-Black"),
                                  textAlign: TextAlign.center)
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 20, 30),
                            child:
                            Center(
                                child: GradientText("WORD APP",
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white60 , Colors.white70, Colors.white60, Colors.white]),
                                    style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailEditingController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        print("log in tapped");
                        _logIn();
                      },
                      textColor: Colors.black,
                      color: Colors.white,
                      height: 50,
                      child: Text("LOGIN"),
                    ),

                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child:
                      InkWell(
                        child:
                        Text("Just show me the Word of the Day!",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () {
                          print("tapped");
                          _pushToWordOfTheDayScreen();
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  List<Word> parseWords(String responseBody) {
    print(responseBody);
    final parsed = json.decode(responseBody);
    var list = parsed.map<Word>((json) => Word.fromJson(json)).toList();
    return list;
  }

  _getWords() async {
    final database = Provider.of<MyDatabase>(context);

    dbAllWords = await database.getAllWords();
    NetworkCalls.getWords().then((response) {
    if (dbAllWords.length == 0) {

        print(response);
        wordsJson = parseWords(response.body);
        for (Word word in wordsJson) {
          print(word);
          database.insertWord(word);

          // fix this:
          guestWordOfTheDay = word;
          print("get words $guestWordOfTheDay");
        }
      }
    }
    );
  }

//  _queryDb() async {
//    DatabaseHelper helper = DatabaseHelper.instance;
//    dbAllWords = await helper.queryAllWords();
//  }

        //    DatabaseHelper helper = DatabaseHelper.instance;
//    _queryDb().then((_) {
//          if (dbAllWords != null) {
//            Word foundWord = dbAllWords.firstWhere((o) => o.word == word.word);
//            Function eq = const DeepCollectionEquality.unordered().equals;
//            if (foundWord != null) {
//              if ((eq(foundWord.selected, word.selected)) == false) {
//                helper.updateWord(word);
//              }
//            }
//          } else {
//            _saveWordToDb(word);
//          }
//        }
//      }).then((_) {
//        _queryDb().then((_) {
//          print("getting guest words");
//          _getGuestWordOfTheDay().then((_) {
//            _pushToTabScreen();
//          });
//        });
//      });
//        ;
//    }  )


//  _saveWordToDb(Word wordJson) async {
////    DatabaseHelper helper = DatabaseHelper.instance;
////    await helper.insert(wordJson);
//    final database = Provider.of<MyDatabase>(context);
//    database.insertWord(wordJson);
//  }

  _logIn() async {
    var response = await NetworkCalls.logIn(email: emailEditingController.text, password: passwordEditingController.text);
    final parsed = json.decode(response.body);
    User user = User.fromJson(parsed);
    if (response.statusCode == 200) {
      SharedPrefsHelper.updateId(user.userID);
      SharedPrefsHelper.updateToken(user.token);
      id = user.userID;
      token = user.token;
      _pushToTabScreen();
    } else {
      showIncorrectCredentialsError();
    }
  }

  _pushToTabScreen() async {
    if (await SharedPrefsHelper.getId() == null || await SharedPrefsHelper.getToken() == null) {
      return;
    }
    dbSelectedWords = [];
    dbUnselectedWords = [];
    for (Word word in dbAllWords) {
      if (word.selected == null) {
        dbUnselectedWords.add(word);
      } else {
//        if (word.selected.contains(id)) {
//          dbSelectedWords.add(word);
//        } else {
//          dbUnselectedWords.add(word);
//        }
      }
    }
    await _getRegisteredWordOfTheDay();
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords, wordOfTheDay: registeredWordOfTheDay, id: id))
    );
  }

  showIncorrectCredentialsError() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Error"),
              content: const Text("There was a problem with your email or password"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        }
    );
  }

  _pushToWordOfTheDayScreen() {
    WordOfTheDayScreen nextScreen = WordOfTheDayScreen(wordOfTheDay: guestWordOfTheDay);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen)
    );
  }

  _getRegisteredWordOfTheDay() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int registeredWordId;
    Word registeredWord;
    bool appOpenedToday = await SharedPrefsHelper.appWasOpenedToday();

    if (appOpenedToday) {
      registeredWordId = await SharedPrefsHelper.getTodaysRegisteredWord();
//      registeredWord = await helper.queryWordById(registeredWordId);
//      registeredWordOfTheDay = registeredWord;

      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("registeredWordOfTheDay"),
      );

    } else {
      final _random = new Random();
      if (dbUnselectedWords.length != 0) {

        int randomNum = 0 + _random.nextInt(dbUnselectedWords.length);
        registeredWord = dbUnselectedWords[randomNum];
        SharedPrefsHelper.updateTodaysRegisteredWord(registeredWord.id);
        registeredWordOfTheDay = registeredWord;
      } else {
        registeredWordOfTheDay = guestWordOfTheDay;
      }
      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("registeredWordOfTheDay"),
      );
      setState(() {
        wordTabController = WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords, wordOfTheDay: registeredWordOfTheDay, id: id);
      });
    }
  }

  _getGuestWordOfTheDay() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int guestWordId;
    Word guestWord;

    bool appOpenedToday = await SharedPrefsHelper.appWasOpenedToday();

    if (appOpenedToday) {
      print("app opened");
      guestWordId = await SharedPrefsHelper.getTodaysGuestWord();
//      guestWord = await helper.queryWordById(guestWordId);
//      guestWordOfTheDay = guestWord;
      print(guestWord);

      PageStorage.of(context).writeState(context, guestWordOfTheDay,
        identifier: ValueKey("guestWordOfTheDay"),
      );

    } else {
      print("app not opened");
      final _random = new Random();
      int randomNum = 0 + _random.nextInt(dbAllWords.length);
      guestWord = dbAllWords[randomNum];
      SharedPrefsHelper.updateTodaysGuestWord(guestWord.id);
      print(guestWord);
      guestWordOfTheDay = guestWord;
      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("guestWordOfTheDay"),
      );
    }
  }
}
