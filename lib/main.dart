import 'package:flutter/material.dart';

import './Champions.dart';
import './MainPage.dart';
import './Settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String title;

  MyApp({this.title});

  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  void setPage(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            _title = titleIndex0;
            _selectedPage = index;
          }
          break;
        case 1:
          {
            _title = titleIndex1;
            _selectedPage = index;
          }
          break;
        case 2:
          {
            _title = titleIndex2;
            _selectedPage = index;
          }
          break;
      }
    });
  }

  int _selectedPage = 0;
  var _pageOptions = [];
  String _title;
  String titleIndex0 = "Strona główna";
  String titleIndex1 = "Postacie";
  String titleIndex2 = "Ustawienia";

  @override
  initState() {
    _title = 'League';
  }

  @override
  Widget build(BuildContext context) {
    _pageOptions = [
      MainPage(),
      Champions(),
      Settings()
    ]; //musi byc tutaj a nie w deklaracji bo inaczej sie wysypuje

    return FutureBuilder(
        future:
        DefaultAssetBundle //DefaultAssetBundle mozna zmienic na swoja jakas funkcje
            .of(context)
            .loadString('json/champions.json'),
        builder: (context, snapshot) {
          jsonSnapshot = snapshot;
          return MaterialApp(
            //trzeba przeniesc logike ladowania jsona do main w async - po co ladowac pare razy to samo
            // Decode the JSON
            title: "FlutterDemo",
            theme: ThemeData(primaryColor: Colors.deepPurple),
            home: Scaffold(
              appBar: AppBar(
                title: Text(_title),
              ),
              body: _pageOptions[_selectedPage],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedPage,
                onTap: (int index) {
                  setPage(index);
                },
                items: [
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text(titleIndex0)),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.list), title: Text(titleIndex1)),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text(titleIndex2)),
                ],
              ),
            ),
          );
        });
  }
}
