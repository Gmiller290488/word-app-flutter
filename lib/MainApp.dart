import 'package:flutter/material.dart';
import 'WordListController.dart';
import 'WordCardController.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  MainApp();

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int index = 0;
  var pages = [
    WordCardController(),
    WordListController()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: pages[index],
            appBar: AppBar(
              title: Text("Word App"),
            ),
//            body: TabBarView(
//                children: [
//                  WordCardController(),
//                  WordListController()
//                ]
//            ),
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.today),
                    title: Text("Word Of The Day"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    title: Text("Word List"),
                  ),
                ],
              currentIndex: index,
              type: BottomNavigationBarType.fixed,
              onTap: (newIndex) {
                  setState(() {
                    index = newIndex;
                  });
              },
            )
        ),
      ),
    );
  }

}




