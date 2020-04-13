
import 'package:flutter/material.dart';

import './Champions.dart';
import './MainPage.dart';
import './Settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  var _pageOptions = [];

  @override
  Widget build(BuildContext context) {
    _pageOptions=[MainPage(), Champions(), Settings()]; //musi byc tutaj a nie w deklaracji bo inaczej sie wysypuje
    return FutureBuilder(
        future: DefaultAssetBundle  //DefaultAssetBundle mozna zmienic na swoja jakas funkcje
        .of(context)
        .loadString('json/champions.json'),
        builder: (context, snapshot) {

          jsonSnapshot = snapshot;
          return MaterialApp( //trzeba przeniesc logike ladowania jsona do main w async - po co ladowac pare razy to samo
            // Decode the JSON
            title: "FlutterDemo",
            theme: ThemeData(primaryColor: Colors.cyanAccent),
            home: Scaffold(
              appBar: AppBar(
                title: Text('League'),
              ),
              body: _pageOptions[_selectedPage],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedPage,
                onTap: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("strona główna")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), title: Text("champions")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text("ustawienia")),
                ],
              ),
            ),
          );
        }
    );
    // TODO: implement build
  }
}
