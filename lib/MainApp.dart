import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_app_fl/Utils/database.dart';
import 'UserLogin.dart';

void main() => runApp(MainApp());

//class MainApp extends StatefulWidget {
//
//  MainApp();
//  @override
//  _MainAppState createState() => _MainAppState();
//}
//
//class _MainAppState extends State<MainApp> {
//
//  @override
//  void initState() {
//    super.initState();
//  }

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => MyDatabase(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UserLogin(),
      ),
    );
  }


}




