import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'WordTabController.dart';
import 'Utils/word.dart';
import 'Utils/database_helpers.dart';
import 'Networking/NetworkCalls.dart';
import 'dart:convert';
import 'Utils/shared_prefs_helpers.dart';
import 'dart:math';
import 'WordOfTheDayScreen.dart';

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
  static List<Word> dbSelectedWords;
  static List<Word> dbUnselectedWords;
  static List<Word> dbAllWords;

  @override
  void initState() {

    _getWords();
    wordTabController = WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords, wordOfTheDay: registeredWordOfTheDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        _pushToCardScreen();
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

  _queryDb() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    dbSelectedWords = await helper.queryAllSelectedWords();
    dbUnselectedWords = await helper.queryAllUnselectedWords();
    dbAllWords = await helper.queryAllWords();

    await _getWordOfTheDay();
  }

  _getWords() async {
    NetworkCalls.getWords().then((response) {
      List<Word> wordsJson = parseWords(response.body);
      for (Word word in wordsJson) {
        _saveWordToDb(word);
      }
      _queryDb();
    });
  }

  static List<Word> parseWords(String responseBody) {
    print(responseBody);
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    var list = parsed.map<Word>((json) => Word.fromJson(json)).toList();
    return list;
  }

  _saveWordToDb(Word wordJson) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.insert(wordJson);
  }

  _pushToCardScreen() {

    WordTabController nextScreen = WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords, wordOfTheDay: registeredWordOfTheDay);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen)
    );
  }

  _pushToWordOfTheDayScreen() {

    WordOfTheDayScreen nextScreen = WordOfTheDayScreen(wordOfTheDay: guestWordOfTheDay);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen)
    );
  }

  _getWordOfTheDay() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int guestWordId;
    int registeredWordId;
    Word guestWord;
    Word registeredWord;

    bool appOpenedToday = await SharedPrefsHelper.appWasOpenedToday();

    if (appOpenedToday) {
      registeredWordId = await SharedPrefsHelper.getTodaysRegisteredWord();
      registeredWord = await helper.queryWordById(registeredWordId);
      registeredWordOfTheDay = registeredWord;

      guestWordId = await SharedPrefsHelper.getTodaysGuestWord();
      guestWord = await helper.queryWordById(guestWordId);
      guestWordOfTheDay = guestWord;

      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("registeredWordOfTheDay"),
      );
      PageStorage.of(context).writeState(context, guestWordOfTheDay,
        identifier: ValueKey("guestWordOfTheDay"),
      );

    } else {
      final _random = new Random();
      int randomNum = 0 + _random.nextInt(dbUnselectedWords.length);
      registeredWord = dbUnselectedWords[randomNum];
      SharedPrefsHelper.updateTodaysRegisteredWord(registeredWord.id);
      registeredWordOfTheDay = registeredWord;

      final _guestRandom = new Random();
      int guestRandomNum = 0 + _guestRandom.nextInt(dbAllWords.length);
      guestWord = dbAllWords[guestRandomNum];
      SharedPrefsHelper.updateTodaysGuestWord(guestWord.id);


      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("registeredWordOfTheDay"),
      );
      guestWordOfTheDay = guestWord;
      PageStorage.of(context).writeState(context, registeredWordOfTheDay,
        identifier: ValueKey("guestWordOfTheDay"),
      );
      setState(() {
        wordTabController = WordTabController(dbSelectedWords: dbSelectedWords, dbUnselectedWords: dbUnselectedWords);
      });
    }
  }
}
