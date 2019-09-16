import 'package:flutter/material.dart';
import 'UserLogin.dart';
import 'Utils/Word.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {

  MainApp();
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UserLogin(),
    );
  }


}




