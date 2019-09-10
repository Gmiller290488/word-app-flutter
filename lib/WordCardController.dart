import 'package:flutter/material.dart';

class WordCardController extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: AssetImage(
//            'Assets/Images/books.jpeg'),
//            fit: BoxFit.fill,
//        )
//      ),
        child: Center(
        child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                    title: Text("Bulwark"),
                    subtitle: Text("Definition: A defensive wall")
                )
              ],
            )
        )
        )
    );
  }
}

