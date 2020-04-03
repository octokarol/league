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
  final _pageOptions = [
    MainPage(),
    Champions(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterDemo",
      theme: ThemeData(primaryColor: Colors.cyanAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leauge'),
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
                icon: Icon(Icons.list), title: Text("rotacja")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text("ustawienia")),
          ],
        ),
      ),
    );
    // TODO: implement build
    return null;
  }
}
